PGDMP  0    !                }            DrCell    17.4    17.4 0    j           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            k           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            l           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            m           1262    24883    DrCell    DATABASE     n   CREATE DATABASE "DrCell" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-MX';
    DROP DATABASE "DrCell";
                     postgres    false            �            1259    24884    usuarios    TABLE     �   CREATE TABLE public.usuarios (
    "Id" integer NOT NULL,
    "Email" character varying(150),
    "ClaveHash" character varying(256),
    "Rol" character varying(150)
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    24889    Usuario_Id_seq    SEQUENCE     �   ALTER TABLE public.usuarios ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Usuario_Id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    217            �            1259    24890    baterias    TABLE     �   CREATE TABLE public.baterias (
    id integer NOT NULL,
    modelo character varying(100),
    marca character varying(100),
    costo numeric(10,2),
    arreglo numeric(10,2),
    tipo character varying(100)
);
    DROP TABLE public.baterias;
       public         heap r       postgres    false            �            1259    24893    baterias_id_seq    SEQUENCE     �   ALTER TABLE public.baterias ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.baterias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    219            �            1259    24894 	   celulares    TABLE     �   CREATE TABLE public.celulares (
    id integer NOT NULL,
    modelo character varying(100),
    marca character varying(100)
);
    DROP TABLE public.celulares;
       public         heap r       postgres    false            �            1259    24897    celulares_id_seq    SEQUENCE     �   CREATE SEQUENCE public.celulares_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.celulares_id_seq;
       public               postgres    false    221            n           0    0    celulares_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.celulares_id_seq OWNED BY public.celulares.id;
          public               postgres    false    222            �            1259    24898    modulos    TABLE     *  CREATE TABLE public.modulos (
    id integer NOT NULL,
    modelo character varying(100),
    marca character varying(100),
    costo numeric(10,2),
    arreglo numeric(10,2),
    color character varying(50),
    marco boolean,
    tipo character varying(100),
    version character varying(50)
);
    DROP TABLE public.modulos;
       public         heap r       postgres    false            �            1259    24901    modulos_id_seq    SEQUENCE     �   ALTER TABLE public.modulos ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.modulos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    223            �            1259    24902    pines    TABLE     �   CREATE TABLE public.pines (
    id integer NOT NULL,
    modelo character varying(256),
    marca character varying(256),
    costo numeric(10,2),
    arreglo numeric(10,2),
    tipo character varying(150),
    placa numeric(150,0)
);
    DROP TABLE public.pines;
       public         heap r       postgres    false            �            1259    24907    pines_id_seq    SEQUENCE     �   ALTER TABLE public.pines ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.pines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    225            �            1259    24908 	   productos    TABLE     �   CREATE TABLE public.productos (
    "Id" integer NOT NULL,
    marca character varying(150),
    modelo character varying(150),
    categoria character varying(100),
    img bytea
);
    DROP TABLE public.productos;
       public         heap r       postgres    false            �            1259    24913    productos_id_seq    SEQUENCE     �   ALTER TABLE public.productos ALTER COLUMN "Id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.productos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    227            �            1259    24914    productos_variantes    TABLE       CREATE TABLE public.productos_variantes (
    "Id" integer NOT NULL,
    "ProductoId" integer NOT NULL,
    stock integer,
    color character varying(100) NOT NULL,
    ram character varying(100),
    precio numeric(18,2),
    almacenamiento character varying
);
 '   DROP TABLE public.productos_variantes;
       public         heap r       postgres    false            �            1259    24919    productos_variantes_Id_seq    SEQUENCE     �   CREATE SEQUENCE public."productos_variantes_Id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public."productos_variantes_Id_seq";
       public               postgres    false    229            o           0    0    productos_variantes_Id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public."productos_variantes_Id_seq" OWNED BY public.productos_variantes."Id";
          public               postgres    false    230            �            1259    24920 	   vcelularb    VIEW       CREATE VIEW public.vcelularb AS
 SELECT c.id AS celularid,
    c.modelo,
    c.marca,
    b.tipo,
    b.arreglo AS arreglobateria
   FROM (public.celulares c
     LEFT JOIN public.baterias b ON ((((c.modelo)::text = (b.modelo)::text) AND ((c.marca)::text = (b.marca)::text))));
    DROP VIEW public.vcelularb;
       public       v       postgres    false    219    221    221    221    219    219    219            �            1259    24924 	   vcelularm    VIEW     =  CREATE VIEW public.vcelularm AS
 SELECT c.id AS celularid,
    c.modelo,
    c.marca,
    m.color,
    m.marco,
    m.tipo,
    m.version,
    m.arreglo AS arreglomodulo
   FROM (public.celulares c
     LEFT JOIN public.modulos m ON ((((c.modelo)::text = (m.modelo)::text) AND ((c.marca)::text = (m.marca)::text))));
    DROP VIEW public.vcelularm;
       public       v       postgres    false    221    221    221    223    223    223    223    223    223    223            �            1259    24928 	   vcelularp    VIEW       CREATE VIEW public.vcelularp AS
 SELECT DISTINCT ON (c.marca, c.modelo) c.marca,
    c.modelo,
    p.costo,
    p.placa,
    p.tipo
   FROM (public.celulares c
     JOIN public.pines p ON (((p.marca)::text = (c.marca)::text)))
  ORDER BY c.marca, c.modelo;
    DROP VIEW public.vcelularp;
       public       v       postgres    false    225    225    225    225    221    221            �            1259    24932    vcelularmbp    VIEW     �  CREATE VIEW public.vcelularmbp AS
 SELECT c.marca,
    c.modelo,
    m.marco,
    m.color,
    m.tipo,
    m.version,
    p.placa,
    p.tipo AS tipopin,
    m.arreglomodulo,
    b.arreglobateria AS arreglobat,
    p.costo AS arreglopin
   FROM (((public.celulares c
     LEFT JOIN public.vcelularb b ON (((c.modelo)::text = (b.modelo)::text)))
     LEFT JOIN public.vcelularm m ON (((c.modelo)::text = (m.modelo)::text)))
     LEFT JOIN public.vcelularp p ON (((c.modelo)::text = (p.modelo)::text)));
    DROP VIEW public.vcelularmbp;
       public       v       postgres    false    221    233    233    233    233    232    232    232    232    232    232    231    231    221            �           2604    24937    celulares id    DEFAULT     l   ALTER TABLE ONLY public.celulares ALTER COLUMN id SET DEFAULT nextval('public.celulares_id_seq'::regclass);
 ;   ALTER TABLE public.celulares ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221            �           2604    24938    productos_variantes Id    DEFAULT     �   ALTER TABLE ONLY public.productos_variantes ALTER COLUMN "Id" SET DEFAULT nextval('public."productos_variantes_Id_seq"'::regclass);
 G   ALTER TABLE public.productos_variantes ALTER COLUMN "Id" DROP DEFAULT;
       public               postgres    false    230    229            \          0    24890    baterias 
   TABLE DATA           K   COPY public.baterias (id, modelo, marca, costo, arreglo, tipo) FROM stdin;
    public               postgres    false    219   O;       ^          0    24894 	   celulares 
   TABLE DATA           6   COPY public.celulares (id, modelo, marca) FROM stdin;
    public               postgres    false    221   ZM       `          0    24898    modulos 
   TABLE DATA           a   COPY public.modulos (id, modelo, marca, costo, arreglo, color, marco, tipo, version) FROM stdin;
    public               postgres    false    223   �U       b          0    24902    pines 
   TABLE DATA           O   COPY public.pines (id, modelo, marca, costo, arreglo, tipo, placa) FROM stdin;
    public               postgres    false    225   �_       d          0    24908 	   productos 
   TABLE DATA           H   COPY public.productos ("Id", marca, modelo, categoria, img) FROM stdin;
    public               postgres    false    227   �d       f          0    24914    productos_variantes 
   TABLE DATA           l   COPY public.productos_variantes ("Id", "ProductoId", stock, color, ram, precio, almacenamiento) FROM stdin;
    public               postgres    false    229   |       Z          0    24884    usuarios 
   TABLE DATA           E   COPY public.usuarios ("Id", "Email", "ClaveHash", "Rol") FROM stdin;
    public               postgres    false    217   �|       p           0    0    Usuario_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Usuario_Id_seq"', 3, true);
          public               postgres    false    218            q           0    0    baterias_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.baterias_id_seq', 1106, true);
          public               postgres    false    220            r           0    0    celulares_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.celulares_id_seq', 634, true);
          public               postgres    false    222            s           0    0    modulos_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.modulos_id_seq', 876, true);
          public               postgres    false    224            t           0    0    pines_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.pines_id_seq', 1194, true);
          public               postgres    false    226            u           0    0    productos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.productos_id_seq', 12, true);
          public               postgres    false    228            v           0    0    productos_variantes_Id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."productos_variantes_Id_seq"', 35, true);
          public               postgres    false    230            �           2606    24944    usuarios Usuario_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT "Usuario_pkey" PRIMARY KEY ("Id");
 A   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT "Usuario_pkey";
       public                 postgres    false    217            �           2606    24946    baterias baterias_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.baterias
    ADD CONSTRAINT baterias_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.baterias DROP CONSTRAINT baterias_pkey;
       public                 postgres    false    219            �           2606    24948    celulares celulares_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.celulares
    ADD CONSTRAINT celulares_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.celulares DROP CONSTRAINT celulares_pkey;
       public                 postgres    false    221            �           2606    24950    modulos modulos_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.modulos DROP CONSTRAINT modulos_pkey;
       public                 postgres    false    223            �           2606    24952    pines pines_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.pines
    ADD CONSTRAINT pines_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.pines DROP CONSTRAINT pines_pkey;
       public                 postgres    false    225            �           2606    24954 ,   productos_variantes productos_variantes_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.productos_variantes
    ADD CONSTRAINT productos_variantes_pkey PRIMARY KEY ("Id");
 V   ALTER TABLE ONLY public.productos_variantes DROP CONSTRAINT productos_variantes_pkey;
       public                 postgres    false    229            �           2606    24956    productos venta_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT venta_pkey PRIMARY KEY ("Id");
 >   ALTER TABLE ONLY public.productos DROP CONSTRAINT venta_pkey;
       public                 postgres    false    227            �           2606    24957    productos_variantes fk_producto    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos_variantes
    ADD CONSTRAINT fk_producto FOREIGN KEY ("ProductoId") REFERENCES public.productos("Id") ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.productos_variantes DROP CONSTRAINT fk_producto;
       public               postgres    false    229    227    4801            \      x���K�ܸ���_�c����&��MO��c���mrq#1⬃�I�}��GK=bذ�O%�H��"�[)�ZV�ñ�fw��_�?������f���
(�R�E 4IX$(�`�bx�6�
�Peu�h���bP��P����U�`Ď,J �Z�2D�ű��m����VA\�~��ϯK`R���au�d�Qu��4-K���p���阕�	���% ���I67��`;�O�n䂂hٳv�����
o�-#km�v�����o�� �Vd���@���3S}���7go`�k�y}���N�����dYf�h.y��S��-� ~�~� g-�����8k7�H��[ ����[̂���B���4gj΂��Ij�6k�a��Đ��Ǚ͂���ߠ�Z j�%7J��N)�V11da��Qq�����P���М�4`淤�G$�ӄ���MӪ0U�Cu�%���������ח������0Q��hDv_�J0���
I��N��%�{��P��� �F%�T0��~��@�p'�q�O��(Nm�j09F�?D�� c��D�+Zh�����Јk�!H& C#Q����H�r��=Ҡ��=+�@5�h@�D64z֌0ܗ�hM���X ��V-8!��S�>�$�'iLvS4�`�
��㤁��x�aZ�H��i��:��{�<�Y0��79�|�ޯ[�Q��Rm7�z]�J�H���W��#Qӡ� �#�a{>64�:�t�Z�N��!�t��`��1�Yk���0���FG�W��@��@�a4BIF�k�M"`�[o@ŖA"谑Z��V�53fӂ��N�Cs�Â�#T]`�,�������!Cc�rZ��m�Z���_{:w4�.���]`�Ik3��૮ø����W�ݤ�0�4�ر��:r�N�E��4����Xre5Bxea2 �� 8�d�SFKB�A"����1i�Ak��Z�!n%�jЪ'*��n<Q� �wP���z ߻��g��8t���7��S�{�E�ޒ��>9VR �x��焀g����8v;��p׺5@��uj��� �T��	\��1�a�.R�{E`�[E� � �� �b�	�꤈� ��	�?V�*�yA�0Pϣ��+i�9'�OA!�(�,�I;6�Ǌ��n�tTujW���qs�����ْ/q�n���^C�XZy
���mΙ�^<�Ëƨz6��)p z�W;es�JV��屩��w#s�Nd�^ˀ�*���g�zꔭI�gr�X�g�U�r<�ԙ/{(��Iw�,�B|��*��l3����e��46W�`��=�Ҹ��4�z�9����3: �幛����u��z��� h��ydĶ=�G�}ق�2����l��s�h���=�v?�e>�ۏmfā's�Vͮz����=mp�3��ٍ�fF�̀3���$iĈmq\��T�cE�`��Ub���8?@5��{=��1�g2�Q���;�2i�ߣ&0=��R�W�;1y�	.���.�ۜ0av9
��Q}�����
�z���#�"�a�U*��^���a�U�6\���>+���VG)!\;<�E��[�fл'�h���|��)A��#�L3(��f�&e��?ԠO�6�8B�(;h�2"V���`}��˛dh�V�)'��7�2�F�k��mլΛÞ&u"?nN,i���'��Ww��B���K{��Ú������HH"�z8�H.�$�/g��:me�ӕ g�A������������zU��|ZD��]�����z��O
	)3�c{L��#�.������5��P�M�;� ��~���/�GH���Ԙ����V4�����/߄R˜+=B�,�7���#�8&5�҄QȋUd� 6��m�+�ؾ�~�qa��,-���S �&s�*���yw�~d)#>b�|�v��v{8�0Ŀ"������k�r�����p�c�5m:O��-hA��@�R�H���z7����+�/\}�/C�ғ�إ�b`��p�bp�2�6Ч^¼��#�@�pf$F�u�*^T]�8�^�4!�'kG��e�A���,e|w��t�V�9���2�Rf`��,�Ԥ����PH�G���=́П�j�u��®9F	{☔S��H�ej��p�:���e0�h�\�{@��N�/J�!S&��t ��ȸEX_˶8��ᩝW�-�̨S��~�q�XF��]X�.C�ڹt��D�Z��Dh��4���@�f9$�}B�yߓ9PN:_�Q�Ηc����3�'��f���4�o��q�nY�>V��Al�&26�`>���]sڬ�Q@r�f̌�5!�s��~�}g�5�0�]P���yJ�k���ʨ
2.��m�[��3}�Z\x���*�X(pQn�{\#�����bv2��ƴ�^�M�����m[��ώ�.���U���Eí	[ޝ�1����YI���qe����D,w/x����d���,n"d�M�`������urLi$��+*0���/��s2c
F2��d뮧XB����$F���,A�y��#B=���|3��<�����Й�L��}�PCw�%_S%�1��͆@�v�PhS��6��HXo��[�+ӢA�X#ʺ(�eD8��i��??R�O^�O�C��}C,�Q��l'���k&�bu���0�W7v����'�Ǖ�y�Z��LL��)�����<ݢ�U0?-X���LC��Z�*����WC�L�RX���c;}ay�Z��}vx!7�T���a��I�O�.����Wj�g�xޡs���UAk��cz�|������棗�qȖ/|�Gp]�J�:yJa�sA�%&'���TWO϶�vH,}���_Jq�%��]r�/]�|�;q��/|���*Ր��͎�w)��Ue)����0���cUA��uɡ�C��$��U�&�S�t������6�dd���ᅩ�Z���V�2Vc�uj��l��1�eG8۰Ű��4���<��d�K��v��`<��o:��ڔųÈ�5xn�ē�z^�C��/�/�l�5�kV�C�+�#϶��C&}�|_$��&_=�ڒ7����UZ^���4cL{]��fW�UI�����pZ\؉�q���TY9Ҏ��]�;���S	�g�x�
��
-/�Y�k�p8�Z����⏯��P��̬;%^��i}�ū.�j���o����5�Xg��j�a�i�	��:(�I/�a���5�T�����LR���{�r^A��u=%#J��0Uw�����������A6���t}�]��
'٥K&
��V�R:ృR8�ۤ�G00�{�[j]L�tU1��4�bZ�+��q�ߦQ��/��N[����	7�K�Ja\֬��|	D�q1+���BrI	z����e�媔V�ƐRWq��+�p�s���v�R:+���d�S��=�k�,��7y�27�q�NW��������2����@�2�� .���P�,�Je�C�<�8<��Y(b��Y���T��IF�}U��d+!��I쭒���ē��W�x7[�t��TJ��Y)��"�(~�9��@f�,Ni
Zk�}�6�X�����S��:���
�v������Gn9ތ���V���ȋ��SN�	n��Y�w�bz�Zk��t˰Ck%8}km�d����kտp��Zx��oh�W	p��Δ���`N<(���� Bn���Su����b� J>6�{lq/������v���}{`Y%�d���IN$//�8�{�Ӱ1����3�b]��r(�O��<@�Y G�^Ke���rt���:Z��o�����`��T;�7�Αf��9�N���ܛj�H?J��n��2~����2<Ջp0'x$�3.%<���Q[�B;��v�z���df]^�q�`����eT���Ѭrqi�9�*�����B��:aƫrqT��.o�9߷ҁSx;7`N��cCϒE>��.���!Z�ײ���q�c���Z�u�|�B9-�w*L��e0��YP���U�|!]��ܞYP�` �  e�nB6\0A��A�7&0�po�Lgx]77�0��������8�>7�1��!	������6B�pU����k� ���8�9����D�J�"��,'D���i�4�cI����$�Z��&�wM�F�����8��(p�(�BG��z�]���pK%�K#i$�W��9�Uф�[�P�Y���|��{�դ�'E�I��
@+ +�0��B�"0]V�.��Oѧ�l�[4D^)q#.�i�v�nFx/;2^������e��+�]mP������~�l����5+E��nH� ��k�ǥ��������zWD�R��R��Yx8Hngg�3��#,�~?��G��;��:��WQ�A�.d)��0C	h��b�F��*��h�S}����9�\�����l��Y��f������e��B�ex?�����m-�����!��}������o���:݆ny`/DFMK�_\�pߋ-v��O���O?��&�c�      ^   �  x�u�Mo������1A0�?ţ�-k���n��{�C���Y ??/���b{o��E�e�U��Fu�F�O�^]����8< #��貘�%�gs�,G]cn����c�R�h�f���j?i�����<� q贘N��s+�<����Mv�m2S�H�YaxZ����	S�o�@�I`DѐP�IB�jb6Y3�#&N��,Bi�z��} ��Ͱ�j�p�LK2-dzf�l�,�7�!��*,4Z�ڭ
a:h�"��6+ܻA�g�ٹ�%�JY�]�]�#��fo2S6��L/���2ѽ��=F��C`��<�E��C[���6�ЗX�6��9��Շ�qC��R�*oC��,3,�`Ֆ�~p�����|FrР���j���ys`n-��JjK�A`�Q*Ap������D�mAb��F�:BsKV@�R�cT�+b�B�:�������e�m�)U�&3V�0�Y�'F\!��/�e=w��m�f탵!��`�0阷[[¸��>�t�8��dՐm���Ӿ�B+E8At+�$Od�7I�-��ƣ���������Q"`���Y�CIة�P���Y�z0hg�/����؝7'�t>�ݞ�!s?���I?ZT�}�FV��b" ����N�p�sj�C!,���>?��l�퟿tz�ts�Ԑ����J�ݨ���.k���L
��;�r�ݨ�ffO(t�eʗ�XH[��7��D��0�(370=n\���~���a�ĬS�����%p�I�}t�Y}3]�e<��.���a��ȫ]�;;�y���&K���ivd��rH�8 �vi�B��t�_��d v�B�=oΛ����Fd���|7�8_���~�hH��^w���b� ��Ǝ�o����}����H*�~~�ʴ�`S �&۩r���}!��#(�w�E~�(�;S͖ԹDC����L�H�,���Th8/�2*Gtj´<c���0���������ezh$A��#��QٟOk�$
����l� �
猥͍]nU?�D(�h�(X��#�C�XX�fqb$�8K��I/�:����;�v�k�n��A?C�`��cp�atWq����ͷ �gB��5�Gyw7/)�Y�y=�yܼ���͋��s�Rs�גh�.}[?��e��W��қ�������-�9�+a����n��U|��[ۧ������mtKBS���=�hoD�L����^l�;Ե�y˹��A���,�!V��"Cf�R���e��fE1[G,����"j�nxA�jEl�XwQ���"�QED(��F}Z���ۊhP&℁'������U�������G�M��WxL-V�%�c&��o���I�n�l����琑�^8�੷XV1�)O�W~MVP����_���H��K8�<"��U�Q-8$�8]�� �ڪ��g�p�/d��^x,jꚽS����4d�U=7���~�ρ}��D�QC�JňɄ�5\���s�ثވ�aQ&{�� �p2` e�a尷�Up}P�z���wu$P�z�eQ�������x�9�q�rH�܆�P�Di�C�e�|��C}XaD���]�Qm�(�	���һ��u��T�l9����48E�*��kh�{�`���}�5ٱɍ�1Lf���pl���3��A�T��
s��&��
��3eg0`�Y��Pp/<�8�0���.���'cm^��3� hx
8�!�2+B�P�����
�C:u�8���I�Vn#�u8������Z�V�-�!t�8�q�|�&��RϏW�!p"�tx��tx�X�9쫡�g���P|��\t&L��W�~�r�P`o|}dMqi��i�.rx�X��5C����ː�鱳2����?{ݭ��ӑs_��ͥ�𧗚G��nK�o�X:v�$s(=h��VŽ��7��_O��xC�׏l����G���Tx���ų�ftw8��G�[�z7fR���x���
�U��9�2���o����!�	�?W/,��X��q�����Sl�^�u�����w}����a�m�O���}c����u�� KK������j�H�m���3�L?u��{�;�O����NY����*��\_�&���_�sٟ�Җ_b2���J�b�?O�j���i��#6��:ܭ9����W���������5�      `   �	  x���Ko$����_Q�`"Q�c�]��L�=붳��^�`�lH������J]9h�JI������������_�(��|"d`�b��<�}��<���Ga�//s ��]# 43���|z�D ��kE���)��Js3L ^�&��يӝ�oC���IS�Ǘ�	���R�3=����1~{y|���d怟���}b!"n�
�9|�V@��~j����&4��'./�CJ�}�P���9�*��;.���pF;g'ղ��#��XF���d���K���c�������9Ǩ�ڙ�>U�Z�!��@6j�o緰�AC_A�`iP�<[����[���@V,L�c,���A���9Vh�)'Ч
��C/�kbx�����͵#($�G��YzxB�ݘ�1Šx4���\����9�$�m�T�y�#`'||;��L!�1������>���T��d�W>q.��R̺W|�*���$(+G	(��ݕ6(M�ɷ�ٔk��e� ���M��a6����Z*��e��2��S4�_�mљ�f�v���������ǟ��`�H�"OlY<M*˖z������8>_^��ц*��t��3��3.��?����+���!6̘"y�1c��5�z�ϨY���,3,$�&�F?1!�e�U�	�4�v&�J5=���%������ZC�ƔŌ#p݁�B��p����(yu�/͍�#��@]�,��Al7��Z^�&�L��to.t���#�/�6��,]0�.�oL���>C�+�/qNho,��w��k�E�ʺ�p�y�ߜ�p����Uv�e��޹���S$V�Z�������~M)��EcNtK��LE������h�0�1�0^�E.}S�Q&���^&N�d�B��p�Y��ˤ�¸3����D�ա�����pq]~�_�:�O�D�&W�����]����$��ځ���@8;���	緐t�1�cI�
��"�c6_s��1��ʆ�4	M��y�WLV���B�=Mc�+���bPQ���x�(��D�ZѦu��R�,�,��n�6Ҥ�)B����Nf��U�(�4�*��-t2k]M���g�I��v�+Q�����b�m�J��kuɀ]r܄�� �����C�5�Z,nƉ;j�e�a�Z��2,�K�>�a~��nޡ���"<�V�Qy�SA��v�&$
B>R�i�+ۄ6���Y�{���%�;���[8��z<��kNs�hw��R,AamA�(r$4HXI�&yu7ϰ�;r=��q��B�N�`��E����X��ɢu���sd�������}D�X�a��� �xo�r�m ��Ұ�'86���hcO����'q+�����P
�g�~ǰ�:1^���3e�t�'��Qx��n�v^'.������ID�)�< ���������W�Ǔ���wQ���j劜Ȫ�G�A��|�o��KU����`�RLZMx�i[L�m���ԟҸ��Xm�)�ʺ~9ct��g7�%J��[����^g�����Z�`5�.-wok���w[�V�J�a�l�#R{A�jjAk����or�Y[a>��Ȉ�6#�e�>A���ґU��a��y��L�p-L '���h�BUy@��J �j�a�J���C �����H�Ri��� ���ꌫڷ�L��YV���߶�H�R�J��/j��7Mӊ�g��W̤��y"]����J_+.����jml�C�B�O$Ld�~�����"�7&.2���(����Jph���2F�jS�'�J����!+=[��`kTn� ����V{ѻ�D�XR	iÞO�l�ձf���.��Tw�Gzd�	̞�ft��؊%�f}��S��.�И�+S9�h���LLkr;�Y��_�jc�_����^Ds�#�繂�M�U�q�}�<�u^�1�`�߮	F!?x-4��f�Y��ł���zL_Y�L�f�c������)*�My:�����"��2������rL��
w�e��oOp��
,?�/8,�����N8vR�H�	)�K �-�31��Ie�L��e��қ �cXT$!W&i5�H��HH�w�(]�{�
g�k*�]*�X��"�*�o�e�4�N��:�e���|>Ow�Z�Z�u]1���D��|�_�v;'��_�f������$2� �r���������#DI_��f#��vӀ-�Jب[iۿ��Kw�T�%���sG']��Y�F8�A�/N�� �
�R!+n�[h�[�'�d�L�j:� �,�rIK���BI�I�9�J�1��+XG�tE4]�7�|�n�I"-�M��v!CeC�2�Ɲ��&ݪ�8c��W���6.�}��<������&`��wҭ�4�6�Id��%����6�-��`�P�b	.��>�\^N;�����"웢a�e��V
i��(����������l<N      b     x��W[v�8�VV�tJ��S&
��@I�>��Y�ll�$�8iw��˥U���JRj������Jl�k+7��)#�x�ҙ����a�$�����Ҽ�3�55/}��M�`"R���.�Zw�uON��vR���{���:!O;�ۻ���5���������{W� �Q\ �Hb�	ih�N
�C�¦~�-J2r�|��r&?`�M	Y�~#CR�ɓ��z��4����6,�����m��S&�9�X�u�CN��|�tTX��ot����`�۴~�Q`l]���q<�a+�BR�{�b��8�"e��S����_�g�U}�+���x^��v�����Mu���v!�V�|�统�E�zP��iV�1�MC���2Z�%��^�Y���9/�����L�8��p��i��9��y,�����P��+gC<I������u6�����vs'��מG�K��}G����!4��c8\��ws��L[8s��44c3#w�DPC�&��+�`�Hc��2��Y{'9� �Z~PZ,�� K��hV���}���h&�δưZ��V3� "('z�a-cƖ��C4�5W��P��|�}��Ѳ�$����!���1N�^���}����{�+�*���ӏT�Ny�((S�����V�|@v.�!A<DO�+ϖKvX��\�_�@ҬJ�gB�i�7�Ϟ�XٳLZu��p�P�_��_j�0��ƻ6����<:(���HE��o�!XI
�W*_�Π����x����yk�hwo�S/�B��P%O�&�D(}24��T�4��^j���������o�n��Z�����|�?��
�@eT+"@< �"WKF��D2�}�I��Ǽ��<��E���x�}�TP�,Y��5�PLo6B�����ُ��ǚ��0�\a�̖3T�p7�����	-�:Z�HĀ#'\K�Z��˾�;u*Ԡ��*�V����
�����9�Hrf�6�o����d�x൲�Ag*Ī��ƛ�"g���΢*�!I#�q]�����_���Vrh}��\�=���\����O��=�� k�O}E[��y��k�0L�ۥ��Tm-�f��8�|�JH��`�9��t+��lC*�h{���Ya.����4�i��"�ۥ�����b���X	+G"@��]x��gnxl_��X��!�vx�A=+1 �r�M%~)�����M0,�� �u4��#9ͥ�v��i@Ipʓ�����tJN��d�d0d���~Z^�+o=?n�׏Kz-u2��D�C�C������?�OOO����      d      x��Ɏe7r�ץ��$�����Ն�����������,�K� ��*O�<����ڧ?��ӏ�ӿ����������������4���������Bl1�\���O*1Ő\��YM�u�|�����_��h���{�x~{�D{~�w�%�Cp���:7(�����/��+��<�:<���.럽��4�����y�:(��_�|ś�����~����o���R��+��}r_�)��s}~���������}	���oϵIHgI����y���)����������2�E�����������5��y�5�����V�����g#���y�I!K�_�d|�m��\�+AWz���-�z��������OqS��y�O�|Ga>�D��) �7��w�?��qo˯�f^�\�9F�\��ۊ���B�1�^�o��&��Ֆ[޻��&"{����i��и�q���˜�v����J=�V��5��9�N�)���a�]��c�\S��F��󊫷{����a���Z-ĝ��s4�d����Fi�:�0�qkíѣ���Q>�rr:����{����r����G#Ŭ�i���� ������v$B��û�k�)T��:�����N.�_!ǵr��zu��j�>.�w+k�o������C�<���C�)�8C�y��1�6v�'������c#wͻ�4}����9��v#���BL�M_��=ϙ @3�:�_��Ǳ{�_�C�d����䦳`[�e�,� ��VB��K���s�1�Xv�t�Xc>�Ξ!�(��[%@�{+�\݁A�@��)^��o�� 6��,\T����sT��"��y�: �zX/�2�)Hp1�y8��������w8iWA	����U&^��f�ieuR.���-����<k3y�/.����8 l��~���Cn�`��*$s�jy/�7�m�Yv���S�r�S����Zm��ðs�����
������'�]��/���t��A�����zs�헵"*;R_Xݧ��l�[���Ɉ>g~��D�=�>i���~T��9$�VJ3�B�΍�Z5*�p��TH(3�ڎ��C� ��,��I�Ҁ�-$��
�0r��j�b�:�>k��g��9d7H��:\*1[���*\���� Y�HNB�������o�aL���X<����'�%"߶7*�.�!���Ļ�Xf� G��([?bc�'��MHf�mDjo29�*���=���<�ĳ���Ʋ�xg�f���<%���3��vYV*��ޱs4ۜ��H&�T�$,"��>�ۛ��9s
��.��|(�""��-R_�U��=�%��!��On�����+��dئ,��̭�/ nd�_g�!�`�m�����j1�I���v �)����D,Ϙq�.�ͪ�r��R�ydG�s����g���~ �4�g� ���Z/؈L��w�8B��d�f�����v"	霖��1
C�E�^b�kH>����\�++�؀�!]W�����pIL�ʥ������%�V�V�X�i'�Oc�����[�w�����1�*O��gK)�`��B��S��!5M��aITB�[j2Q8���h}�6c"Re72���O"�{#iB�N��rD�"�Q�)�jw�/��p�0j�hSh�l�tܑ�Se��ʥI&P�G�	����n%��Fh�_�}�����)��!��,.�Q�EF/Ɨ�����})�d�N�DH���;�0+�QP=a�d�j�zD�P��-z�w�#L
Ͷq&�+��J&e����̥˪��@�&V{w,���6�y6�R�3� ��&����>�a�6�He�WC��]�A�Ձ���+�z Yl�2�
�;���'�(��!����gP�=`��x�$����`ܰ	 �V8���F�w_�?v(	���%�#�yBD�B#��xF��� �4'��%�� �%�-��R5����ټ����u���,�� �C��>l��i�B*-��[(�(���[�|H���E�!cȋ�k9���h�Y/N&��L�ڱt�D�@XiY��N#��K�_�p����ŭ�2)���5�Ur�kd-gG��RV�VJ�ʂ�G-�θ<hKe6(�3���%V��$)�n�����t�"@�Y���@����������K&�I8*��ciF�砪!C"N9��qHփj�>�챛��jǠ�Zk�`.��p[�^���*���<�Jc������ ِz�T�ڈj N�{!�H�h�E^6[=�Q�z �A�V������aq`M���g�W�k�����gBfE����6-��'I������t���@Ô3�8`�>S6T\�P����&{@��v$+��MA���T��t�V�y�0����bo-L�1GRs�f�p/4����!^�M~��	DPph$z� ]�a�� ��+�E�>�	�HX˕���I`�k�G��{�>6���D�,L�*	��G�m���۝s#r�J~��j045�^4r/��𕬡�;~�]��jLڭ!4;k�aE��R1P�U���6���@���H*/��R����JYy��K�wn��sֱ�01�js�zĬ  ~%�`3k�GAY��"qAiG�����UC�#9�������!��V�	��C�ױ�)2���*В�{�G�0DS�g"�ʆ2UdW/��0	_�SPV�;AA
�S���AH��]��N˯��(lp��t�;��KF�g �
og$uJ�037��I�`�:�4�U�C}b�i�G�&d��nk/��?#�E�����FK���X�D�&3Yq�N��:�C��Z�]�hLE��$ b��-�� Q(eX��i�Љ, ?R��*��l �Q5����
�!z���+�W[��%Á|�A�R�(���$~C����dF�����C�p,1�"��<���F��(��0(	�ŠH���\���bPt�"G!��L��\R���o��n,HkO�!Tػ`�()Kva�A�h��{ħ��fCN��M�^�m�#%��1�kց�ܚ�������. .(ڨڧB�#��vU��2A�FEg�o�� X('m.E$Z` ��6�i�r�<�  �"�HL���l+ )�7�ʝ�^F� l�^��Y���D���3 jI��P\��q;��6.����
��'�
|����R9���S�.����'2��&���h���Cv�洴O<���n�Mb�R��C(A\8:����W�FZ�P��z���)��1���e������661�}�aľ+z��*�";�@��6�C����Ց�sd~�"�����Ě�\2r(0�[�oZv ~���/iDH2.��z�WR��Z*�4�H
&�5����RqД^61<;M���3P�df��`�@���b��M)�L܄k84u����^h��P� �?HZ"��H;(s��NPJ�;vN��۲mɼLb��͕gZN;=��h	���=r�r�@�pY 8��d0`J�U�!~����`U0�B����e�V���Üs�0�3�MTB�w�(�6qX[��Ťq�S��}%�+u(n��qb�q*؍�_&�U�ME1�7�:��+(��i��D��CA�;JX��G�	���*td��p��a�)�2�%�Тb�Mf�A 2fD�k�g�Lt�j�&��5f]Pi��Lz'E��oR�m|&3p�|P��T	��6���GS��n�hܒ�F�q^�F&��El�^H0�2j��Gꀌ�r<�2�H/W�t8�9X��r�C�'��(;�:�4h��8���dj_R��bbi�G��,X> ����)D�#���?����)��}���i�EגHӼ��B�S�=aS�I���6ǭcB�"8"���!� P�����Ԭ����g@�
��D^�RT����}1�Թu䄓*�(fp��D�MHz� � Nh'��pxI�
h	D�/sK� �i�%D�S.x�>$3 P  ����G��Q� &(aX�(�����i�H�$�!���'3!m�k7s�L��A��Ƞ]����Q;0��w1dWi�jJ�G�i��^nՎ��6;�S�l�s�[�@�~�>k��ym~�8%�cS��=����	aB��8���w�㎴�.υ-I�8LD52T�86�?��FV������Bˬ1b	P�Mj����P�'�#{���RR����Ba5Q�[/�Y=�:�#v0В4!'�t�@�/����[�ZZ }XS ��<�_�(h�F�����oxL�Nվ�����|ä��D��$�e1P�A��$NÍ$�����o����"jޛ(���c�&W����ζ�6yj��c�`CرTꀀ"�I��2AlST��6H�����dN �A����2!θJC�P_�ʛ� ��#^ﶶ�
IH-\ �?0���x0��e�QO	���6�~*�#eq�0�А��<�i.�7$�h�HD����?>
c���D��b���`�
{�)U���ar�W�(���2�,$�	 ������M����%4:+W��^ۨ�1�`�J"���n��r��B�D�	�!�e�c9u�0U���y�8�&]3�Z�kܤ��sQ�R�`I�z��6��G�Y� l��_�u�� aj#IM�r�{����f�$���@m;��A������M�-��z����l,+`��k�D�S�,��84I@�6H�
8���@��5^'6F�sǨ�A����"Ut&�X[��K�⧂�r6���>�X/([��S�էMB����w��1'pa���`'�U �OI0��+�C|^�I;)5��>���h�fm�b���7����9�o%Ó�Q�&��h����xY���d@Nm(f���daP<��x���]�@�%c�΢�қ(�q�C� s���8���蒃-Q���DïC<p�@�W��~�e�G�1�h��wЋ� 3�6�<�.����|`h$D�cXm,�&��:(��,�<{WC��T�E�PRGI�\M�hP*�Ϯz}��ڞ$R2�U���s��I"���$����IVY/�$� \/i�2
�����O}bb-Y�fj�BϰL���Z@l55O.�6�
�	���ߢ�i�� h3��"ԡ`��K�3�IB�#��d0��
Bц�c���dz�*���4I�p�Қ�$��!' <����9�ql(�J M���;nx�&���^�e�\A,��
z5)��=�0�n,h���Z�
���B��\e�I�W��D��;���q�Y-Y��8 e�"�+�<�bF�`��P�Mm@ck�p�3�U�np=�#�1�MΑ�D��j"�^0"�P��F����'�8(����	8��5C3%S�z��G�f�wDK���&�wŎ;	r�k��2����$��	h��:���W@�y���?�����O
�D������ܖ��1ߖ����8�-��%�Dޖ��y["oK�m��-��%�Dޖ��y["oK�m��-��%�Dޖ��y["oK�m��-��%�Dޖ��y["oK�m��-��%���?�������ӟoO�o��=����|�퉼=�����y{"oO�퉼=��'��Dޞ��y{"oO�퉼=��'��Dޞ��y{"oO�퉼=��'��Dޞ��y{"oO�퉼=��'��Dޞ��y{"� =����&��ߖ���s["_���>��y["��%�Dޖ��y["oK�m��-��%�Dޖ��y["oK�m��-��%�Dޖ��y["oK�m��-��%�Dޖ��y["oK�m��-��%�D�1Z"����� di�      f   k   x�Uͽ
�0���0��?�U7gA\
}��T�h���YFƐ�%ı�oI�!��0���W�B���B,X3���	Z��*�+����
���נbN���7��s*m"�      Z   ^   x�3�LL���3t Sz����*F�*��*���^e�z��fI�.�9���!A�f��A&@��h��RedfhVT������������� G$     