------------------------------------------------------------------------------
-- Sample Symmetric Configuration
------------------------------------------------------------------------------
-- SymmetricDS configuration needs to be inserted via a SQL script at the master node.

delete from SYM_TRANSFORM_COLUMN;
delete from SYM_TRANSFORM_TABLE;

delete from sym_trigger_router;
delete from sym_trigger;
delete from sym_router;
delete from sym_channel where channel_id in ('EK2_PERSONA');
delete from sym_node_group_link;
delete from sym_node_group;
delete from sym_node_host;
delete from sym_node_identity;
delete from sym_node_security;
delete from sym_node;

insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('EK2_PERSONA', 1, 100000, 1, 'Persona table data');

insert into sym_node_group (node_group_id) values ('MASTERS');
insert into sym_node_group (node_group_id) values ('SLAVES');

insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('MASTERS', 'SLAVES', 'W');
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('SLAVES', 'MASTERS', 'P');

insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('EK2_PERSONA','EK2_PERSONA','EK2_PERSONA',current_timestamp,current_timestamp);

insert into sym_router 
(router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
values('MASTERS_2_SLAVES', 'MASTERS', 'SLAVES', 'default',current_timestamp, current_timestamp);

insert into sym_trigger_router 
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('EK2_PERSONA','MASTERS_2_SLAVES', 100, current_timestamp, current_timestamp);

insert into SYM_TRANSFORM_TABLE (
        transform_id, source_node_group_id, target_node_group_id, transform_point, source_table_name,
        target_table_name, update_action, delete_action, transform_order, column_policy, update_first,
        last_update_by, last_update_time, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', 'MASTERS', 'SLAVES', 'EXTRACT', 'EK2_PERSONA',
        'EK1_TERCERO', 'UPDATE_COL', 'DEL_ROW', 1, 'SPECIFIED', 1,
        'Documentation', current_timestamp, current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk, 
		transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'ID', 'ID', 1,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'X_SYNC_CORR1', 'ID', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_TIPO', 'TIPO_PERSONA', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_IDENT', 'IDENTIFICACION', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_TIPODOC', 'TIPO_IDENTIFICACION', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_NOM', 'NOMBRES', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_AP1', 'APELLIDOS', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_TELEFONO', 'CELULAR', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);

insert into SYM_TRANSFORM_COLUMN (
        transform_id, include_on, target_column_name, source_column_name, pk,
        transform_type, transform_expression, transform_order, last_update_time, last_update_by, create_time
) values (
        'EK2PERS_2_EK1TERC_TRANSFORM', '*', 'TER_EMAIL', 'EMAIL_PERSONAL', 0,
        'copy', '', 1, current_timestamp, 'Documentation', current_timestamp
);




insert into sym_node (node_id,node_group_id,external_id,sync_enabled,sync_url,schema_version,symmetric_version,database_type,database_version,heartbeat_time,timezone_offset,batch_to_send_count,batch_in_error_count,created_at_node_id) 
 values ('master','MASTERS','000',1,null,null,null,null,null,current_timestamp,null,0,0,'master');
insert into sym_node (node_id,node_group_id,external_id,sync_enabled,sync_url,schema_version,symmetric_version,database_type,database_version,heartbeat_time,timezone_offset,batch_to_send_count,batch_in_error_count,created_at_node_id) 
 values ('slave1','SLAVES','001',1,null,null,null,null,null,current_timestamp,null,0,0,'master');

insert into sym_node_security (node_id,node_password,registration_enabled,registration_time,initial_load_enabled,initial_load_time,created_at_node_id) 
 values ('000','5d1c92bbacbe2edb9e1ca5dbb0e481',0,current_timestamp,0,current_timestamp,'master');
insert into sym_node_security (node_id,node_password,registration_enabled,registration_time,initial_load_enabled,initial_load_time,created_at_node_id) 
 values ('001','5d1c92bbacbe2edb9e1ca5dbb0e481',1,null,1,null,'master');

insert into sym_node_identity values ('master');
insert into sym_node_identity values ('slave1');


