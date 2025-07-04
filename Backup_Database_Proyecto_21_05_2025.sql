PGDMP      
    	            }         	   Proyecto     16.4    16.4 w    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    131227 	   Proyecto     DATABASE     ~   CREATE DATABASE "Proyecto " WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "Proyecto ";
                postgres    false            �            1255    131505 $   actualizar_asignacion(integer, date)    FUNCTION     �   CREATE FUNCTION public.actualizar_asignacion(p_id integer, p_fecha date) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE asignacionesproyecto
    SET fecha_asignacion = p_fecha
    WHERE id_asignacion = p_id;
END;
$$;
 H   DROP FUNCTION public.actualizar_asignacion(p_id integer, p_fecha date);
       public          postgres    false                       1255    131515 ,   actualizar_evento(integer, text, date, text)    FUNCTION       CREATE FUNCTION public.actualizar_evento(p_id_evento integer, p_nombre text, p_fecha date, p_lugar text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE eventos
    SET nombre = p_nombre, fecha = p_fecha, lugar = p_lugar
    WHERE id_evento = p_id_evento;
END;
$$;
 h   DROP FUNCTION public.actualizar_evento(p_id_evento integer, p_nombre text, p_fecha date, p_lugar text);
       public          postgres    false            �            1255    131502 1   actualizar_proyecto(integer, text, text, integer)    FUNCTION     /  CREATE FUNCTION public.actualizar_proyecto(p_id integer, p_nombre text, p_descripcion text, p_id_estado integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE proyectos
    SET nombre = p_nombre, descripcion = p_descripcion, id_estado = p_id_estado
    WHERE id_proyecto = p_id;
END;
$$;
 p   DROP FUNCTION public.actualizar_proyecto(p_id integer, p_nombre text, p_descripcion text, p_id_estado integer);
       public          postgres    false                       1255    131509 :   actualizar_registro_horas(integer, integer, date, integer)    FUNCTION     E  CREATE FUNCTION public.actualizar_registro_horas(p_id_registro integer, p_id_asignacion integer, p_fecha date, p_horas integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE registrohoras
    SET id_registro = p_id_registro, fecha = p_fecha, horas = p_horas
    WHERE id_asignacion = p_id_asignacion;
END;
$$;
    DROP FUNCTION public.actualizar_registro_horas(p_id_registro integer, p_id_asignacion integer, p_fecha date, p_horas integer);
       public          postgres    false            �            1255    131489 <   actualizar_voluntario(integer, text, text, text, text, text)    FUNCTION     p  CREATE FUNCTION public.actualizar_voluntario(p_id integer, p_nombre text, p_apellido text, p_email text, p_telefono text, p_direccion text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE voluntarios
    SET nombre = p_nombre, apellido = p_apellido, email = p_email, telefono = p_telefono, direccion = p_direccion
    WHERE id_voluntario = p_id;
END;
$$;
 �   DROP FUNCTION public.actualizar_voluntario(p_id integer, p_nombre text, p_apellido text, p_email text, p_telefono text, p_direccion text);
       public          postgres    false                       1255    131530    auditar_asignacion_proyecto()    FUNCTION     �  CREATE FUNCTION public.auditar_asignacion_proyecto() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, id_registro, descripcion)
    VALUES (
        'asignacionesproyecto',
        'INSERT',
        NEW.id_asignacion,
        CONCAT('Voluntario ', NEW.id_voluntario, ' asignado al proyecto ', NEW.id_proyecto)
    );
    RETURN NEW;
END;
$$;
 4   DROP FUNCTION public.auditar_asignacion_proyecto();
       public          postgres    false            	           1255    131534    auditar_inscripcion_evento()    FUNCTION     �  CREATE FUNCTION public.auditar_inscripcion_evento() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, id_registro, descripcion)
    VALUES (
        'inscripcionesevento',
        'INSERT',
        NEW.id_inscripcion,
        CONCAT('Voluntario ', NEW.id_voluntario, ' se inscribió al evento ', NEW.id_evento)
    );
    RETURN NEW;
END;
$$;
 3   DROP FUNCTION public.auditar_inscripcion_evento();
       public          postgres    false                       1255    131532    auditar_registro_horas()    FUNCTION     �  CREATE FUNCTION public.auditar_registro_horas() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO auditoria(tabla_afectada, operacion, id_registro, descripcion)
    VALUES (
        'registrohoras',
        'INSERT',
        NEW.id_registro,
        CONCAT('Se registraron ', NEW.horas, ' horas para la asignación ', NEW.id_asignacion)
    );
    RETURN NEW;
END;
$$;
 /   DROP FUNCTION public.auditar_registro_horas();
       public          postgres    false                        1255    131506    eliminar_asignacion(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_asignacion(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM asignacionesproyecto
    WHERE id_asignacion = p_id;
END;
$$;
 8   DROP FUNCTION public.eliminar_asignacion(p_id integer);
       public          postgres    false                       1255    131516    eliminar_evento(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_evento(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM eventos
    WHERE id_evento = p_id;
END;
$$;
 4   DROP FUNCTION public.eliminar_evento(p_id integer);
       public          postgres    false            �            1255    131503    eliminar_proyecto(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_proyecto(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM proyectos
    WHERE id_proyecto = p_id;
END;
$$;
 6   DROP FUNCTION public.eliminar_proyecto(p_id integer);
       public          postgres    false                       1255    131510     eliminar_registro_horas(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_registro_horas(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM registrohoras
    WHERE id_registro = p_id;
END;
$$;
 <   DROP FUNCTION public.eliminar_registro_horas(p_id integer);
       public          postgres    false            �            1255    131490    eliminar_voluntario(integer)    FUNCTION     �   CREATE FUNCTION public.eliminar_voluntario(p_id integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    DELETE FROM voluntarios
    WHERE id_voluntario = p_id;
END;
$$;
 8   DROP FUNCTION public.eliminar_voluntario(p_id integer);
       public          postgres    false            �            1255    131504 4   insertar_asignacion(integer, integer, integer, date)    FUNCTION     f  CREATE FUNCTION public.insertar_asignacion(p_id_asignacion integer, p_id_voluntario integer, p_id_proyecto integer, p_fecha date) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO asignacionesproyecto(id_asignacion, id_voluntario, id_proyecto, fecha_asignacion)
    VALUES (p_id_asignacion, p_id_voluntario, p_id_proyecto, p_fecha);
END;
$$;
 �   DROP FUNCTION public.insertar_asignacion(p_id_asignacion integer, p_id_voluntario integer, p_id_proyecto integer, p_fecha date);
       public          postgres    false                       1255    131513 9   insertar_evento(integer, text, text, date, text, integer)    FUNCTION     t  CREATE FUNCTION public.insertar_evento(p_id_evento integer, p_nombre text, p_descripcion text, p_fecha date, p_lugar text, p_id_proyecto integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO eventos(id_evento, nombre, descripcion, fecha, lugar, id_proyecto)
    VALUES (p_id_evento, p_nombre, p_descripcion, p_fecha, p_lugar, p_id_proyecto);
END;
$$;
 �   DROP FUNCTION public.insertar_evento(p_id_evento integer, p_nombre text, p_descripcion text, p_fecha date, p_lugar text, p_id_proyecto integer);
       public          postgres    false            �            1255    131499 8   insertar_proyecto(integer, text, text, integer, integer)    FUNCTION     f  CREATE FUNCTION public.insertar_proyecto(p_id_proyecto integer, p_nombre text, p_descripcion text, p_id_estado integer, p_id_causa integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO proyectos(id_proyecto, nombre, descripcion, id_estado, id_causa)
    VALUES (p_id_proyecto, p_nombre, p_descripcion, p_id_estado, p_id_causa);
END;
$$;
 �   DROP FUNCTION public.insertar_proyecto(p_id_proyecto integer, p_nombre text, p_descripcion text, p_id_estado integer, p_id_causa integer);
       public          postgres    false                       1255    131507 8   insertar_registro_horas(integer, integer, date, integer)    FUNCTION     @  CREATE FUNCTION public.insertar_registro_horas(p_id_registro integer, p_id_asignacion integer, p_fecha date, p_horas integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO registrohoras(id_registro, id_asignacion, fecha, horas)
    VALUES (p_id_registro, p_id_asignacion, p_fecha, p_horas);
END;
$$;
 }   DROP FUNCTION public.insertar_registro_horas(p_id_registro integer, p_id_asignacion integer, p_fecha date, p_horas integer);
       public          postgres    false            �            1255    131485 :   insertar_voluntario(integer, text, text, text, text, text)    FUNCTION     ~  CREATE FUNCTION public.insertar_voluntario(p_id_voluntario integer, p_nombre text, p_apellido text, p_email text, p_telefono text, p_direccion text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO voluntarios(id_voluntario,nombre, apellido, email, telefono, direccion)
    VALUES (p_id_voluntario, p_nombre, p_apellido, p_email, p_telefono, p_direccion);
END;
$$;
 �   DROP FUNCTION public.insertar_voluntario(p_id_voluntario integer, p_nombre text, p_apellido text, p_email text, p_telefono text, p_direccion text);
       public          postgres    false                       1255    131539 9   sp_actualizar_asignacion(integer, integer, integer, date) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_actualizar_asignacion(IN p_id_asignacion integer, IN p_id_voluntario integer, IN p_id_proyecto integer, IN p_fecha_asignacion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM asignacionesproyecto WHERE id_asignacion = p_id_asignacion) THEN
        RAISE EXCEPTION 'No existe la asignación con ID %', p_id_asignacion;
    END IF;

    UPDATE asignacionesproyecto
    SET id_voluntario = p_id_voluntario,
        id_proyecto = p_id_proyecto,
        fecha_asignacion = p_fecha_asignacion
    WHERE id_asignacion = p_id_asignacion;

    RAISE NOTICE 'Asignación actualizada correctamente.';
END;
$$;
 �   DROP PROCEDURE public.sp_actualizar_asignacion(IN p_id_asignacion integer, IN p_id_voluntario integer, IN p_id_proyecto integer, IN p_fecha_asignacion date);
       public          postgres    false                       1255    131537 +   sp_crear_asignacion(integer, integer, date) 	   PROCEDURE     &  CREATE PROCEDURE public.sp_crear_asignacion(IN p_id_voluntario integer, IN p_id_proyecto integer, IN p_fecha_asignacion date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Validar existencia del voluntario y proyecto
    IF NOT EXISTS (SELECT 1 FROM voluntarios WHERE id_voluntario = p_id_voluntario) THEN
        RAISE EXCEPTION 'El voluntario con ID % no existe', p_id_voluntario;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM proyectos WHERE id_proyecto = p_id_proyecto) THEN
        RAISE EXCEPTION 'El proyecto con ID % no existe', p_id_proyecto;
    END IF;

    -- Insertar la asignación
    INSERT INTO asignacionesproyecto (id_voluntario, id_proyecto, fecha_asignacion)
    VALUES (p_id_voluntario, p_id_proyecto, p_fecha_asignacion);

    RAISE NOTICE 'Asignación creada exitosamente.';
END;
$$;
 }   DROP PROCEDURE public.sp_crear_asignacion(IN p_id_voluntario integer, IN p_id_proyecto integer, IN p_fecha_asignacion date);
       public          postgres    false                       1255    131538    sp_eliminar_asignacion(integer) 	   PROCEDURE     �  CREATE PROCEDURE public.sp_eliminar_asignacion(IN p_id_asignacion integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM asignacionesproyecto WHERE id_asignacion = p_id_asignacion) THEN
        RAISE NOTICE 'La asignación con ID % no existe.', p_id_asignacion;
    ELSE
        DELETE FROM asignacionesproyecto
        WHERE id_asignacion = p_id_asignacion;
        RAISE NOTICE 'Asignación eliminada correctamente.';
    END IF;
END;
$$;
 J   DROP PROCEDURE public.sp_eliminar_asignacion(IN p_id_asignacion integer);
       public          postgres    false            �            1259    131314    asignacionesproyecto    TABLE     �   CREATE TABLE public.asignacionesproyecto (
    id_asignacion integer NOT NULL,
    id_voluntario integer,
    id_proyecto integer,
    fecha_asignacion date DEFAULT CURRENT_DATE
);
 (   DROP TABLE public.asignacionesproyecto;
       public         heap    postgres    false            �           0    0    TABLE asignacionesproyecto    ACL     �   GRANT ALL ON TABLE public.asignacionesproyecto TO administrador_ong;
GRANT SELECT,INSERT,UPDATE ON TABLE public.asignacionesproyecto TO coordinador_proyecto;
          public          postgres    false    230            �            1259    131313 &   asignacionesproyecto_id_asignacion_seq    SEQUENCE     �   CREATE SEQUENCE public.asignacionesproyecto_id_asignacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.asignacionesproyecto_id_asignacion_seq;
       public          postgres    false    230            �           0    0 &   asignacionesproyecto_id_asignacion_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.asignacionesproyecto_id_asignacion_seq OWNED BY public.asignacionesproyecto.id_asignacion;
          public          postgres    false    229            �           0    0 /   SEQUENCE asignacionesproyecto_id_asignacion_seq    ACL     Z   GRANT ALL ON SEQUENCE public.asignacionesproyecto_id_asignacion_seq TO administrador_ong;
          public          postgres    false    229            �            1259    131521 	   auditoria    TABLE     �   CREATE TABLE public.auditoria (
    id_auditoria integer NOT NULL,
    tabla_afectada text,
    operacion text,
    id_registro integer,
    fecha timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    descripcion text
);
    DROP TABLE public.auditoria;
       public         heap    postgres    false            �           0    0    TABLE auditoria    ACL     :   GRANT ALL ON TABLE public.auditoria TO administrador_ong;
          public          postgres    false    247            �            1259    131520    auditoria_id_auditoria_seq    SEQUENCE     �   CREATE SEQUENCE public.auditoria_id_auditoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.auditoria_id_auditoria_seq;
       public          postgres    false    247            �           0    0    auditoria_id_auditoria_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.auditoria_id_auditoria_seq OWNED BY public.auditoria.id_auditoria;
          public          postgres    false    246            �           0    0 #   SEQUENCE auditoria_id_auditoria_seq    ACL     N   GRANT ALL ON SEQUENCE public.auditoria_id_auditoria_seq TO administrador_ong;
          public          postgres    false    246            �            1259    131286    causas    TABLE     w   CREATE TABLE public.causas (
    id_causa integer NOT NULL,
    nombre character varying(100),
    descripcion text
);
    DROP TABLE public.causas;
       public         heap    postgres    false            �           0    0    TABLE causas    ACL     g   GRANT ALL ON TABLE public.causas TO administrador_ong;
GRANT SELECT ON TABLE public.causas TO donante;
          public          postgres    false    226            �            1259    131285    causas_id_causa_seq    SEQUENCE     �   CREATE SEQUENCE public.causas_id_causa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.causas_id_causa_seq;
       public          postgres    false    226            �           0    0    causas_id_causa_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.causas_id_causa_seq OWNED BY public.causas.id_causa;
          public          postgres    false    225            �           0    0    SEQUENCE causas_id_causa_seq    ACL     G   GRANT ALL ON SEQUENCE public.causas_id_causa_seq TO administrador_ong;
          public          postgres    false    225            �            1259    131267    disponibilidadvoluntario    TABLE     �   CREATE TABLE public.disponibilidadvoluntario (
    id_disponibilidad integer NOT NULL,
    id_voluntario integer,
    dia_semana character varying(15),
    hora_inicio time without time zone,
    hora_fin time without time zone
);
 ,   DROP TABLE public.disponibilidadvoluntario;
       public         heap    postgres    false            �           0    0    TABLE disponibilidadvoluntario    ACL     I   GRANT ALL ON TABLE public.disponibilidadvoluntario TO administrador_ong;
          public          postgres    false    222            �            1259    131266 .   disponibilidadvoluntario_id_disponibilidad_seq    SEQUENCE     �   CREATE SEQUENCE public.disponibilidadvoluntario_id_disponibilidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.disponibilidadvoluntario_id_disponibilidad_seq;
       public          postgres    false    222            �           0    0 .   disponibilidadvoluntario_id_disponibilidad_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.disponibilidadvoluntario_id_disponibilidad_seq OWNED BY public.disponibilidadvoluntario.id_disponibilidad;
          public          postgres    false    221            �           0    0 7   SEQUENCE disponibilidadvoluntario_id_disponibilidad_seq    ACL     b   GRANT ALL ON SEQUENCE public.disponibilidadvoluntario_id_disponibilidad_seq TO administrador_ong;
          public          postgres    false    221            �            1259    131385 
   donaciones    TABLE     �   CREATE TABLE public.donaciones (
    id_donacion integer NOT NULL,
    id_donante integer,
    id_proyecto integer,
    monto numeric(10,2),
    fecha date DEFAULT CURRENT_DATE,
    CONSTRAINT donaciones_monto_check CHECK ((monto > (0)::numeric))
);
    DROP TABLE public.donaciones;
       public         heap    postgres    false            �           0    0    TABLE donaciones    ACL     o   GRANT ALL ON TABLE public.donaciones TO administrador_ong;
GRANT INSERT ON TABLE public.donaciones TO donante;
          public          postgres    false    240            �            1259    131384    donaciones_id_donacion_seq    SEQUENCE     �   CREATE SEQUENCE public.donaciones_id_donacion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.donaciones_id_donacion_seq;
       public          postgres    false    240            �           0    0    donaciones_id_donacion_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.donaciones_id_donacion_seq OWNED BY public.donaciones.id_donacion;
          public          postgres    false    239            �           0    0 #   SEQUENCE donaciones_id_donacion_seq    ACL     N   GRANT ALL ON SEQUENCE public.donaciones_id_donacion_seq TO administrador_ong;
          public          postgres    false    239            �            1259    131377    donantes    TABLE     Q  CREATE TABLE public.donantes (
    id_donante integer NOT NULL,
    nombre character varying(100),
    email character varying(100),
    tipo_donante character varying(20),
    CONSTRAINT donantes_tipo_donante_check CHECK (((tipo_donante)::text = ANY ((ARRAY['individual'::character varying, 'empresa'::character varying])::text[])))
);
    DROP TABLE public.donantes;
       public         heap    postgres    false            �           0    0    TABLE donantes    ACL     9   GRANT ALL ON TABLE public.donantes TO administrador_ong;
          public          postgres    false    238            �            1259    131376    donantes_id_donante_seq    SEQUENCE     �   CREATE SEQUENCE public.donantes_id_donante_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.donantes_id_donante_seq;
       public          postgres    false    238            �           0    0    donantes_id_donante_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.donantes_id_donante_seq OWNED BY public.donantes.id_donante;
          public          postgres    false    237            �           0    0     SEQUENCE donantes_id_donante_seq    ACL     K   GRANT ALL ON SEQUENCE public.donantes_id_donante_seq TO administrador_ong;
          public          postgres    false    237            �            1259    131279    estadosproyecto    TABLE     q   CREATE TABLE public.estadosproyecto (
    id_estado integer NOT NULL,
    nombre_estado character varying(30)
);
 #   DROP TABLE public.estadosproyecto;
       public         heap    postgres    false            �           0    0    TABLE estadosproyecto    ACL     @   GRANT ALL ON TABLE public.estadosproyecto TO administrador_ong;
          public          postgres    false    224            �            1259    131278    estadosproyecto_id_estado_seq    SEQUENCE     �   CREATE SEQUENCE public.estadosproyecto_id_estado_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.estadosproyecto_id_estado_seq;
       public          postgres    false    224            �           0    0    estadosproyecto_id_estado_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.estadosproyecto_id_estado_seq OWNED BY public.estadosproyecto.id_estado;
          public          postgres    false    223            �           0    0 &   SEQUENCE estadosproyecto_id_estado_seq    ACL     Q   GRANT ALL ON SEQUENCE public.estadosproyecto_id_estado_seq TO administrador_ong;
          public          postgres    false    223            �            1259    131345    eventos    TABLE     �   CREATE TABLE public.eventos (
    id_evento integer NOT NULL,
    nombre character varying(100),
    descripcion text,
    fecha date,
    lugar character varying(100),
    id_proyecto integer
);
    DROP TABLE public.eventos;
       public         heap    postgres    false            �           0    0    TABLE eventos    ACL     l   GRANT ALL ON TABLE public.eventos TO administrador_ong;
GRANT SELECT ON TABLE public.eventos TO voluntario;
          public          postgres    false    234            �            1259    131344    eventos_id_evento_seq    SEQUENCE     �   CREATE SEQUENCE public.eventos_id_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.eventos_id_evento_seq;
       public          postgres    false    234            �           0    0    eventos_id_evento_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.eventos_id_evento_seq OWNED BY public.eventos.id_evento;
          public          postgres    false    233            �           0    0    SEQUENCE eventos_id_evento_seq    ACL     I   GRANT ALL ON SEQUENCE public.eventos_id_evento_seq TO administrador_ong;
          public          postgres    false    233            �            1259    131249    habilidades    TABLE     �   CREATE TABLE public.habilidades (
    id_habilidad integer NOT NULL,
    id_voluntario integer,
    id_tipo_habilidad integer,
    nivel integer,
    CONSTRAINT habilidades_nivel_check CHECK (((nivel >= 1) AND (nivel <= 5)))
);
    DROP TABLE public.habilidades;
       public         heap    postgres    false            �           0    0    TABLE habilidades    ACL     <   GRANT ALL ON TABLE public.habilidades TO administrador_ong;
          public          postgres    false    220            �            1259    131248    habilidades_id_habilidad_seq    SEQUENCE     �   CREATE SEQUENCE public.habilidades_id_habilidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.habilidades_id_habilidad_seq;
       public          postgres    false    220            �           0    0    habilidades_id_habilidad_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.habilidades_id_habilidad_seq OWNED BY public.habilidades.id_habilidad;
          public          postgres    false    219            �           0    0 %   SEQUENCE habilidades_id_habilidad_seq    ACL     P   GRANT ALL ON SEQUENCE public.habilidades_id_habilidad_seq TO administrador_ong;
          public          postgres    false    219            �            1259    131359    inscripcionesevento    TABLE     �   CREATE TABLE public.inscripcionesevento (
    id_inscripcion integer NOT NULL,
    id_voluntario integer,
    id_evento integer,
    fecha_inscripcion date DEFAULT CURRENT_DATE
);
 '   DROP TABLE public.inscripcionesevento;
       public         heap    postgres    false            �           0    0    TABLE inscripcionesevento    ACL     �   REVOKE ALL ON TABLE public.inscripcionesevento FROM postgres;
GRANT ALL ON TABLE public.inscripcionesevento TO administrador_ong;
          public          postgres    false    236            �            1259    131358 &   inscripcionesevento_id_inscripcion_seq    SEQUENCE     �   CREATE SEQUENCE public.inscripcionesevento_id_inscripcion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.inscripcionesevento_id_inscripcion_seq;
       public          postgres    false    236            �           0    0 &   inscripcionesevento_id_inscripcion_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE public.inscripcionesevento_id_inscripcion_seq OWNED BY public.inscripcionesevento.id_inscripcion;
          public          postgres    false    235            �           0    0 /   SEQUENCE inscripcionesevento_id_inscripcion_seq    ACL     Z   GRANT ALL ON SEQUENCE public.inscripcionesevento_id_inscripcion_seq TO administrador_ong;
          public          postgres    false    235            �            1259    131295 	   proyectos    TABLE     �   CREATE TABLE public.proyectos (
    id_proyecto integer NOT NULL,
    nombre character varying(100),
    descripcion text,
    fecha_inicio date,
    fecha_fin date,
    id_estado integer,
    id_causa integer
);
    DROP TABLE public.proyectos;
       public         heap    postgres    false            �           0    0    TABLE proyectos    ACL     �   REVOKE ALL ON TABLE public.proyectos FROM postgres;
GRANT ALL ON TABLE public.proyectos TO administrador_ong;
GRANT SELECT,INSERT,UPDATE ON TABLE public.proyectos TO coordinador_proyecto;
GRANT SELECT ON TABLE public.proyectos TO donante;
          public          postgres    false    228            �            1259    131294    proyectos_id_proyecto_seq    SEQUENCE     �   CREATE SEQUENCE public.proyectos_id_proyecto_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.proyectos_id_proyecto_seq;
       public          postgres    false    228            �           0    0    proyectos_id_proyecto_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.proyectos_id_proyecto_seq OWNED BY public.proyectos.id_proyecto;
          public          postgres    false    227            �           0    0 "   SEQUENCE proyectos_id_proyecto_seq    ACL     M   GRANT ALL ON SEQUENCE public.proyectos_id_proyecto_seq TO administrador_ong;
          public          postgres    false    227            �            1259    131332    registrohoras    TABLE     �   CREATE TABLE public.registrohoras (
    id_registro integer NOT NULL,
    id_asignacion integer,
    fecha date,
    horas numeric(4,2),
    CONSTRAINT registrohoras_horas_check CHECK ((horas > (0)::numeric))
);
 !   DROP TABLE public.registrohoras;
       public         heap    postgres    false            �           0    0    TABLE registrohoras    ACL     �   GRANT ALL ON TABLE public.registrohoras TO administrador_ong;
GRANT SELECT,INSERT ON TABLE public.registrohoras TO coordinador_proyecto;
GRANT INSERT ON TABLE public.registrohoras TO voluntario;
          public          postgres    false    232            �            1259    131331    registrohoras_id_registro_seq    SEQUENCE     �   CREATE SEQUENCE public.registrohoras_id_registro_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.registrohoras_id_registro_seq;
       public          postgres    false    232            �           0    0    registrohoras_id_registro_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.registrohoras_id_registro_seq OWNED BY public.registrohoras.id_registro;
          public          postgres    false    231            �           0    0 &   SEQUENCE registrohoras_id_registro_seq    ACL     Q   GRANT ALL ON SEQUENCE public.registrohoras_id_registro_seq TO administrador_ong;
          public          postgres    false    231            �            1259    131240    tiposhabilidad    TABLE     �   CREATE TABLE public.tiposhabilidad (
    id_tipo_habilidad integer NOT NULL,
    nombre character varying(50),
    descripcion text
);
 "   DROP TABLE public.tiposhabilidad;
       public         heap    postgres    false            �           0    0    TABLE tiposhabilidad    ACL     ?   GRANT ALL ON TABLE public.tiposhabilidad TO administrador_ong;
          public          postgres    false    218            �            1259    131239 $   tiposhabilidad_id_tipo_habilidad_seq    SEQUENCE     �   CREATE SEQUENCE public.tiposhabilidad_id_tipo_habilidad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.tiposhabilidad_id_tipo_habilidad_seq;
       public          postgres    false    218            �           0    0 $   tiposhabilidad_id_tipo_habilidad_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.tiposhabilidad_id_tipo_habilidad_seq OWNED BY public.tiposhabilidad.id_tipo_habilidad;
          public          postgres    false    217            �           0    0 -   SEQUENCE tiposhabilidad_id_tipo_habilidad_seq    ACL     X   GRANT ALL ON SEQUENCE public.tiposhabilidad_id_tipo_habilidad_seq TO administrador_ong;
          public          postgres    false    217            �            1259    131437    vista_horas_por_proyecto    VIEW     g  CREATE VIEW public.vista_horas_por_proyecto AS
 SELECT p.id_proyecto,
    p.nombre AS nombre_proyecto,
    sum(rh.horas) AS total_horas
   FROM ((public.proyectos p
     JOIN public.asignacionesproyecto ap ON ((p.id_proyecto = ap.id_proyecto)))
     JOIN public.registrohoras rh ON ((ap.id_asignacion = rh.id_asignacion)))
  GROUP BY p.id_proyecto, p.nombre;
 +   DROP VIEW public.vista_horas_por_proyecto;
       public          postgres    false    232    230    232    228    228    230            �           0    0    TABLE vista_horas_por_proyecto    ACL     I   GRANT ALL ON TABLE public.vista_horas_por_proyecto TO administrador_ong;
          public          postgres    false    242            �            1259    131229    voluntarios    TABLE       CREATE TABLE public.voluntarios (
    id_voluntario integer NOT NULL,
    nombre character varying(50),
    apellido character varying(50),
    email character varying(100),
    telefono character varying(20),
    fecha_nacimiento date,
    direccion text
);
    DROP TABLE public.voluntarios;
       public         heap    postgres    false            �           0    0    TABLE voluntarios    ACL     �   GRANT ALL ON TABLE public.voluntarios TO administrador_ong;
GRANT SELECT ON TABLE public.voluntarios TO coordinador_proyecto;
GRANT SELECT ON TABLE public.voluntarios TO voluntario;
          public          postgres    false    216            �            1259    131465 $   vista_proximos_eventos_inscripciones    VIEW     d  CREATE VIEW public.vista_proximos_eventos_inscripciones AS
 SELECT e.id_evento,
    e.nombre AS nombre_evento,
    e.fecha,
    v.id_voluntario,
    v.nombre AS nombre_voluntario
   FROM ((public.eventos e
     JOIN public.inscripcionesevento ie ON ((e.id_evento = ie.id_evento)))
     JOIN public.voluntarios v ON ((ie.id_voluntario = v.id_voluntario)));
 7   DROP VIEW public.vista_proximos_eventos_inscripciones;
       public          postgres    false    216    236    236    234    234    234    216            �           0    0 *   TABLE vista_proximos_eventos_inscripciones    ACL     U   GRANT ALL ON TABLE public.vista_proximos_eventos_inscripciones TO administrador_ong;
          public          postgres    false    243            �            1259    131474 '   vista_proyectos_con_causa_y_voluntarios    VIEW     �  CREATE VIEW public.vista_proyectos_con_causa_y_voluntarios AS
 SELECT p.id_proyecto,
    p.nombre AS nombre_proyecto,
    c.nombre AS causa,
    count(ap.id_voluntario) AS voluntarios_asignados
   FROM ((public.proyectos p
     JOIN public.causas c ON ((p.id_causa = c.id_causa)))
     LEFT JOIN public.asignacionesproyecto ap ON ((p.id_proyecto = ap.id_proyecto)))
  GROUP BY p.id_proyecto, p.nombre, c.nombre;
 :   DROP VIEW public.vista_proyectos_con_causa_y_voluntarios;
       public          postgres    false    230    226    230    226    228    228    228            �           0    0 -   TABLE vista_proyectos_con_causa_y_voluntarios    ACL     X   GRANT ALL ON TABLE public.vista_proyectos_con_causa_y_voluntarios TO administrador_ong;
          public          postgres    false    245            �            1259    131431 +   vista_voluntarios_disponibles_por_habilidad    VIEW     �  CREATE VIEW public.vista_voluntarios_disponibles_por_habilidad AS
 SELECT DISTINCT v.id_voluntario,
    v.nombre,
    v.apellido,
    th.nombre AS habilidad
   FROM (((public.voluntarios v
     JOIN public.habilidades h ON ((v.id_voluntario = h.id_voluntario)))
     JOIN public.tiposhabilidad th ON ((h.id_tipo_habilidad = th.id_tipo_habilidad)))
     JOIN public.disponibilidadvoluntario d ON ((v.id_voluntario = d.id_voluntario)))
  WHERE ((th.nombre)::text = 'Medicina'::text);
 >   DROP VIEW public.vista_voluntarios_disponibles_por_habilidad;
       public          postgres    false    222    216    218    220    220    216    216    218            �           0    0 1   TABLE vista_voluntarios_disponibles_por_habilidad    ACL     \   GRANT ALL ON TABLE public.vista_voluntarios_disponibles_por_habilidad TO administrador_ong;
          public          postgres    false    241            �            1259    131469    vista_voluntarios_mas_activos    VIEW     �  CREATE VIEW public.vista_voluntarios_mas_activos AS
 SELECT v.id_voluntario,
    v.nombre,
    v.apellido,
    sum(rh.horas) AS total_horas
   FROM ((public.voluntarios v
     JOIN public.asignacionesproyecto ap ON ((v.id_voluntario = ap.id_voluntario)))
     JOIN public.registrohoras rh ON ((ap.id_asignacion = rh.id_asignacion)))
  GROUP BY v.id_voluntario, v.nombre, v.apellido
  ORDER BY (sum(rh.horas)) DESC;
 0   DROP VIEW public.vista_voluntarios_mas_activos;
       public          postgres    false    232    232    216    216    216    230    230            �           0    0 #   TABLE vista_voluntarios_mas_activos    ACL     N   GRANT ALL ON TABLE public.vista_voluntarios_mas_activos TO administrador_ong;
          public          postgres    false    244            �            1259    131228    voluntarios_id_voluntario_seq    SEQUENCE     �   CREATE SEQUENCE public.voluntarios_id_voluntario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.voluntarios_id_voluntario_seq;
       public          postgres    false    216            �           0    0    voluntarios_id_voluntario_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.voluntarios_id_voluntario_seq OWNED BY public.voluntarios.id_voluntario;
          public          postgres    false    215            �           0    0 &   SEQUENCE voluntarios_id_voluntario_seq    ACL     Q   GRANT ALL ON SEQUENCE public.voluntarios_id_voluntario_seq TO administrador_ong;
          public          postgres    false    215            �           2604    131317 "   asignacionesproyecto id_asignacion    DEFAULT     �   ALTER TABLE ONLY public.asignacionesproyecto ALTER COLUMN id_asignacion SET DEFAULT nextval('public.asignacionesproyecto_id_asignacion_seq'::regclass);
 Q   ALTER TABLE public.asignacionesproyecto ALTER COLUMN id_asignacion DROP DEFAULT;
       public          postgres    false    230    229    230            �           2604    131524    auditoria id_auditoria    DEFAULT     �   ALTER TABLE ONLY public.auditoria ALTER COLUMN id_auditoria SET DEFAULT nextval('public.auditoria_id_auditoria_seq'::regclass);
 E   ALTER TABLE public.auditoria ALTER COLUMN id_auditoria DROP DEFAULT;
       public          postgres    false    247    246    247            �           2604    131289    causas id_causa    DEFAULT     r   ALTER TABLE ONLY public.causas ALTER COLUMN id_causa SET DEFAULT nextval('public.causas_id_causa_seq'::regclass);
 >   ALTER TABLE public.causas ALTER COLUMN id_causa DROP DEFAULT;
       public          postgres    false    226    225    226            �           2604    131270 *   disponibilidadvoluntario id_disponibilidad    DEFAULT     �   ALTER TABLE ONLY public.disponibilidadvoluntario ALTER COLUMN id_disponibilidad SET DEFAULT nextval('public.disponibilidadvoluntario_id_disponibilidad_seq'::regclass);
 Y   ALTER TABLE public.disponibilidadvoluntario ALTER COLUMN id_disponibilidad DROP DEFAULT;
       public          postgres    false    222    221    222            �           2604    131388    donaciones id_donacion    DEFAULT     �   ALTER TABLE ONLY public.donaciones ALTER COLUMN id_donacion SET DEFAULT nextval('public.donaciones_id_donacion_seq'::regclass);
 E   ALTER TABLE public.donaciones ALTER COLUMN id_donacion DROP DEFAULT;
       public          postgres    false    239    240    240            �           2604    131380    donantes id_donante    DEFAULT     z   ALTER TABLE ONLY public.donantes ALTER COLUMN id_donante SET DEFAULT nextval('public.donantes_id_donante_seq'::regclass);
 B   ALTER TABLE public.donantes ALTER COLUMN id_donante DROP DEFAULT;
       public          postgres    false    237    238    238            �           2604    131282    estadosproyecto id_estado    DEFAULT     �   ALTER TABLE ONLY public.estadosproyecto ALTER COLUMN id_estado SET DEFAULT nextval('public.estadosproyecto_id_estado_seq'::regclass);
 H   ALTER TABLE public.estadosproyecto ALTER COLUMN id_estado DROP DEFAULT;
       public          postgres    false    223    224    224            �           2604    131348    eventos id_evento    DEFAULT     v   ALTER TABLE ONLY public.eventos ALTER COLUMN id_evento SET DEFAULT nextval('public.eventos_id_evento_seq'::regclass);
 @   ALTER TABLE public.eventos ALTER COLUMN id_evento DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    131252    habilidades id_habilidad    DEFAULT     �   ALTER TABLE ONLY public.habilidades ALTER COLUMN id_habilidad SET DEFAULT nextval('public.habilidades_id_habilidad_seq'::regclass);
 G   ALTER TABLE public.habilidades ALTER COLUMN id_habilidad DROP DEFAULT;
       public          postgres    false    219    220    220            �           2604    131362 "   inscripcionesevento id_inscripcion    DEFAULT     �   ALTER TABLE ONLY public.inscripcionesevento ALTER COLUMN id_inscripcion SET DEFAULT nextval('public.inscripcionesevento_id_inscripcion_seq'::regclass);
 Q   ALTER TABLE public.inscripcionesevento ALTER COLUMN id_inscripcion DROP DEFAULT;
       public          postgres    false    235    236    236            �           2604    131298    proyectos id_proyecto    DEFAULT     ~   ALTER TABLE ONLY public.proyectos ALTER COLUMN id_proyecto SET DEFAULT nextval('public.proyectos_id_proyecto_seq'::regclass);
 D   ALTER TABLE public.proyectos ALTER COLUMN id_proyecto DROP DEFAULT;
       public          postgres    false    227    228    228            �           2604    131335    registrohoras id_registro    DEFAULT     �   ALTER TABLE ONLY public.registrohoras ALTER COLUMN id_registro SET DEFAULT nextval('public.registrohoras_id_registro_seq'::regclass);
 H   ALTER TABLE public.registrohoras ALTER COLUMN id_registro DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    131243     tiposhabilidad id_tipo_habilidad    DEFAULT     �   ALTER TABLE ONLY public.tiposhabilidad ALTER COLUMN id_tipo_habilidad SET DEFAULT nextval('public.tiposhabilidad_id_tipo_habilidad_seq'::regclass);
 O   ALTER TABLE public.tiposhabilidad ALTER COLUMN id_tipo_habilidad DROP DEFAULT;
       public          postgres    false    217    218    218            �           2604    131232    voluntarios id_voluntario    DEFAULT     �   ALTER TABLE ONLY public.voluntarios ALTER COLUMN id_voluntario SET DEFAULT nextval('public.voluntarios_id_voluntario_seq'::regclass);
 H   ALTER TABLE public.voluntarios ALTER COLUMN id_voluntario DROP DEFAULT;
       public          postgres    false    215    216    216           