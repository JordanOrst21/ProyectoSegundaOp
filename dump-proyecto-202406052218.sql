PGDMP                      |            proyecto    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16404    proyecto    DATABASE     |   CREATE DATABASE proyecto WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE proyecto;
                postgres    false                        0    0    DATABASE proyecto    ACL     (   GRANT ALL ON DATABASE proyecto TO root;
                   postgres    false    4863                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    5                       0    0    SCHEMA public    ACL     $   GRANT ALL ON SCHEMA public TO root;
                   pg_database_owner    false    5            �            1259    16451    imagen_nota    TABLE     y   CREATE TABLE public.imagen_nota (
    id bigint NOT NULL,
    nota_id bigint,
    url character varying(255) NOT NULL
);
    DROP TABLE public.imagen_nota;
       public         heap    root    false    5            �            1259    16450    imagen_nota_id_seq    SEQUENCE     �   CREATE SEQUENCE public.imagen_nota_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.imagen_nota_id_seq;
       public          root    false    5    220                       0    0    imagen_nota_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.imagen_nota_id_seq OWNED BY public.imagen_nota.id;
          public          root    false    219            �            1259    16437    nota    TABLE     �   CREATE TABLE public.nota (
    id bigint NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    usuario_id bigint
);
    DROP TABLE public.nota;
       public         heap    root    false    5            �            1259    16436    nota_id_seq    SEQUENCE     �   CREATE SEQUENCE public.nota_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.nota_id_seq;
       public          root    false    5    218                       0    0    nota_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.nota_id_seq OWNED BY public.nota.id;
          public          root    false    217            �            1259    16428    usuario    TABLE     �   CREATE TABLE public.usuario (
    id bigint NOT NULL,
    nombre character varying(255) NOT NULL,
    correo character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);
    DROP TABLE public.usuario;
       public         heap    root    false    5            �            1259    16427    usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.usuario_id_seq;
       public          root    false    5    216                       0    0    usuario_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;
          public          root    false    215            \           2604    24624    imagen_nota id    DEFAULT     p   ALTER TABLE ONLY public.imagen_nota ALTER COLUMN id SET DEFAULT nextval('public.imagen_nota_id_seq'::regclass);
 =   ALTER TABLE public.imagen_nota ALTER COLUMN id DROP DEFAULT;
       public          root    false    219    220    220            [           2604    24599    nota id    DEFAULT     b   ALTER TABLE ONLY public.nota ALTER COLUMN id SET DEFAULT nextval('public.nota_id_seq'::regclass);
 6   ALTER TABLE public.nota ALTER COLUMN id DROP DEFAULT;
       public          root    false    218    217    218            Z           2604    16478 
   usuario id    DEFAULT     h   ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);
 9   ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
       public          root    false    216    215    216            �          0    16451    imagen_nota 
   TABLE DATA           7   COPY public.imagen_nota (id, nota_id, url) FROM stdin;
    public          root    false    220   �       �          0    16437    nota 
   TABLE DATA           C   COPY public.nota (id, titulo, descripcion, usuario_id) FROM stdin;
    public          root    false    218   `       �          0    16428    usuario 
   TABLE DATA           ?   COPY public.usuario (id, nombre, correo, password) FROM stdin;
    public          root    false    216   �                  0    0    imagen_nota_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.imagen_nota_id_seq', 6, true);
          public          root    false    219                       0    0    nota_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.nota_id_seq', 13, true);
          public          root    false    217                       0    0    usuario_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.usuario_id_seq', 13, true);
          public          root    false    215            b           2606    24626    imagen_nota imagen_nota_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.imagen_nota
    ADD CONSTRAINT imagen_nota_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.imagen_nota DROP CONSTRAINT imagen_nota_pkey;
       public            root    false    220            `           2606    24601    nota nota_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.nota
    ADD CONSTRAINT nota_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.nota DROP CONSTRAINT nota_pkey;
       public            root    false    218            ^           2606    16480    usuario usuario_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            root    false    216            d           2606    24631 $   imagen_nota imagen_nota_nota_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.imagen_nota
    ADD CONSTRAINT imagen_nota_nota_id_fkey FOREIGN KEY (nota_id) REFERENCES public.nota(id);
 N   ALTER TABLE ONLY public.imagen_nota DROP CONSTRAINT imagen_nota_nota_id_fkey;
       public          root    false    218    220    4704            c           2606    24613    nota nota_usuario_id_fkey    FK CONSTRAINT     }   ALTER TABLE ONLY public.nota
    ADD CONSTRAINT nota_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);
 C   ALTER TABLE ONLY public.nota DROP CONSTRAINT nota_usuario_id_fkey;
       public          root    false    216    4702    218            �   t   x�3�4��())(���O�K.�,(IM�-I�3�K/.I,�L�K�����MLO-�/��X9��X�'����'$�{����;��V:zD���V��T�:��s��cZ[���� Z�c^      �   }   x�3�9���4'_!%U!'Q!/�$��%�8�(� 9�Т<dqC.#������ʔ���̜ �͙�S]��R��X���yxcVJ6P�	q
��L�Sh�eF�BK��s�҂�Аh��D��W� ��X      �   �   x�e�A
�0EדS��Xt��7ō;A�I)M"I�<�3iS�8�x�����:��s��Y�;��� ��V7N@����6_O$+���Ҙ�"�S�-�g0��z"=|j�����*8;۠�FHO�0����H��R.<s��T|碣���'I)CP*�@�%�!�H;�Qu%�:��&ג��LjO     