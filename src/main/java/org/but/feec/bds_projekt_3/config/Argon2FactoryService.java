package org.but.feec.bds_projekt_3.config;

import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;

public class Argon2FactoryService {

    public static final Argon2 ARGON2 = Argon2Factory.create(
            Argon2Factory.Argon2Types.ARGON2id,
            16,
            32
    );


}

