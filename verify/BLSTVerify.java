import supranational.blst.*;

public class BLSTVerify
{
    public static void main( String[] args )
    {
        byte[] msg = "blst-bindings-java".getBytes();
        String DST = "MY-DST";

        byte[] IKM = new byte[32];
        for( int i = 0; i < IKM.length; i++ )
            IKM[i] = (byte)( i + 1 );

        SecretKey sk = new SecretKey();
        sk.keygen( IKM );
        System.out.println( "BLS12-381 keygen: OK" );

        P1 pk = new P1( sk );
        byte[] pk_ser = pk.serialize();

        P2 sig = new P2();
        byte[] sig_ser = sig.hash_to( msg, DST, pk_ser )
                            .sign_with( sk )
                            .serialize();
        System.out.println( "BLS12-381 sign:   OK" );

        P1_Affine pk_aff = new P1_Affine( pk_ser );
        P2_Affine sig_aff = new P2_Affine( sig_ser );

        if( !pk_aff.in_group() )
        {
            System.out.println( "BLS12-381 verify: FAILED (public key not in group)" );
            System.exit( 1 );
        }

        Pairing ctx = new Pairing( true, DST );
        ctx.aggregate( pk_aff, sig_aff, msg, pk_ser );
        ctx.commit();

        if( !ctx.finalverify() )
        {
            System.out.println( "BLS12-381 verify: FAILED" );
            System.exit( 1 );
        }

        System.out.println( "BLS12-381 verify: OK" );
    }
}
