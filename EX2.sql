USE `session_04_ex`;

ALTER TABLE `building`
ADD CONSTRAINT `host_id_fk`
		FOREIGN KEY (`host_id`)
        REFERENCES `host` (`id`),
ADD CONSTRAINT `contractor_id_fk`
		FOREIGN KEY (`contractor_id`)
        REFERENCES `contractor` (`id`);
        
ALTER TABLE `work`
ADD CONSTRAINT `building_id_fk`
		FOREIGN KEY (`building_id`)
        REFERENCES `building` (`id`),
ADD CONSTRAINT `worker_id_fk`
		FOREIGN KEY (`worker_id`)
        REFERENCES `worker` (`id`);
        
ALTER TABLE `design`
ADD CONSTRAINT `bd_building_id_fk`
		FOREIGN KEY (`building_id`)
        REFERENCES `building` (`id`),
ADD CONSTRAINT `architect_id_fk`
		FOREIGN KEY (`architect_id`)
        REFERENCES `architect` (`id`);