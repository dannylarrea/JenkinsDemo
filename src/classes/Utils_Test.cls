public class Utils_Test {

	@testVisible
	private static Map<String,List<User>> createUsersBulk(Boolean toInsert, List<String> profileName_lst, List<Integer> numberOfProfiles_lst){
        
        Map<String,Integer> profNameCount_map = new Map<String,Integer>();
        for(Integer i=0;i<profileName_lst.size();i++){
            profNameCount_map.put(profileName_lst[i],numberOfProfiles_lst[i]);
        }
        List<Profile> prof_lst = [SELECT Id, Name FROM Profile WHERE Name IN: profileName_lst];
        system.debug('profileName_lst: '+profileName_lst);
        system.debug('prof_lst: '+prof_lst);

        Map<Id,String> profIdName_map = new Map<Id,String>();
        for(Profile prof: prof_lst){
            profIdName_map.put(prof.Id,Prof.Name);
        }

        List<User> user_lst = new List<User>();
        Integer numProf = 0;
        for(Profile prof: prof_lst){
            for(Integer i=0;i<profNameCount_map.get(prof.Name);i++){
               user_lst.add(new User(
                    LastName = prof.Name+i+numProf,
                    Alias = prof.Name.substring(0,3)+i+numProf,
                    UserName = prof.Name.replaceAll(' ','_')+'@cr7.siu.12champions.com.dev'+i+numProf,
                    CommunityNickname = prof.Name.substring(0,6)+i+numProf,
                    EmailEncodingKey = 'ISO-8859-1',
                    Email = prof.Name.replaceAll(' ','_')+'@cr7.siu.12champions.com.dev'+i+numProf,
                    TimeZoneSidKey = 'America/Chicago',
                    LocaleSidKey =  'en_US',            
                    ProfileId = prof.Id,
                    LanguageLocaleKey = 'en_US',
                    FederationIdentifier = prof.Name+i+numProf,
                    Core_User_PK__c = prof.Name.substring(0,3)+'PK'+i+numProf
                ));
            }
            numProf++;        
        }
        if(toInsert)
            insert user_lst;

        Map<String,List<User>> profNameUser_map = new Map<String,List<User>>();
        for(User user: user_lst){
            if(user.Core_User_PK__c == 'EOF'){
                profNameUser_map.put('EOF',new List<User>{user});
                continue;
            }
            
            if(profNameUser_map.containsKey(profIdName_map.get(user.ProfileId))){
                List<User> aux = profNameUser_map.get(profIdName_map.get(user.ProfileId));
                aux.add(user);
                profNameUser_map.put(profIdName_map.get(user.ProfileId),aux);
            }
            else {
                profNameUser_map.put(profIdName_map.get(user.ProfileId),new List<User>{user});
            }
        }

        return profNameUser_map;
    }
    
    @testVisible
    private static List<Lead> createLeadBulk(Boolean toInsert, List<String> active_lst, List<Integer> num_lst, List<String> branch_lst){
    	
    	List<Lead> lead_lst = new List<Lead>();
		for(Integer i=0;i<active_lst.size();i++){
			for(Integer j=0;j<num_lst[i];j++){
				if(active_lst[i]=='2'){
					lead_lst.add(new Lead(
			            LastName ='TestLead'+i,
			            Core_NIF__c = generateRandomString(8,true,false,false,false)+generateRandomString(1,false,true,false,false),
			            Email = 'testlead'+i+j+'@cr7.siu.12champions.com.dev'+i+j,
			            Core_Product_Code1__c = String.valueOf(i+j).leftPad(3,'0').substring(0,3),
			            Core_Product_Code2__c = String.valueOf(i+j+1).leftPad(3,'0').substring(0,3),
			            Core_Product_Code3__c = String.valueOf(i+j+2).leftPad(3,'0').substring(0,3),
			            Core_Product_Code4__c = String.valueOf(i+j+3).leftPad(3,'0').substring(0,3),
			            Core_Premium_Product1__c = Integer.valueOf(String.valueOf(i+j).leftPad(3,'0').substring(0,3)),
			            Core_Billing_Postal_Code__c = '28033',
			            Core_Birthdate__c =  system.today()-3650,
			            Core_Gender__c = (Math.mod(j,2)==0)?'1':'2',
			            Core_Branch__c = branch_lst[i],
			            Core_Priority__c = '2',
			            Core_Class__c = '9',
			            Core_Affiliate_Email__c = false,
			            Core_Branch_Mixed__c = branch_lst[i]+String.valueOf(i+j).rightPad(5,'0').substring(0,5),
			            Core_Medofi_PK__c = String.valueOf(i+j).rightPad(6,'0')
		        	));					
				}
				else {
					lead_lst.add(new Lead(
			            LastName ='TestLead'+i,
			            Core_NIF__c = generateRandomString(8,true,false,false,false)+generateRandomString(1,false,true,false,false),
			            Email = 'testlead'+i+j+'@cr7.siu.12champions.com.dev'+i+j,
			            Core_Product_Code1__c = String.valueOf(i+j).leftPad(3,'0').substring(0,3),
			            Core_Product_Code2__c = String.valueOf(i+j+1).leftPad(3,'0').substring(0,3),
			            Core_Product_Code3__c = String.valueOf(i+j+2).leftPad(3,'0').substring(0,3),
			            Core_Product_Code4__c = String.valueOf(i+j+3).leftPad(3,'0').substring(0,3),
			            Core_Premium_Product1__c = Integer.valueOf(String.valueOf(i+j).leftPad(3,'0').substring(0,3)),
			            Core_Billing_Postal_Code__c = '28033',
			            Core_Birthdate__c =  system.today()-3650,
			            Core_Gender__c = (Math.mod(j,2)==0)?'1':'2',
			            Core_Branch__c = branch_lst[i],
			            Core_Branch_Mixed__c = branch_lst[i]+String.valueOf(i+j).rightPad(5,'0').substring(0,5),
			            Core_Medofi_PK__c = String.valueOf(i+j).rightPad(6,'0')
		        	));
				}				
			}
		}
		
		if(toInsert)
			insert lead_lst;
			
		return lead_lst;
    }
    
    @testVisible
	private static Map<String,List<Account>> createAccountBulk(Boolean toInsert, List<String> type_lst, List<Integer> num_lst){
    	
    	Map<String,Integer> accTypeCount_map = new Map<String,Integer>();
        for(Integer i=0;i<type_lst.size();i++){
            accTypeCount_map.put(type_lst[i],num_lst[i]);
        }
    	
    	List<Account> acc_lst = new List<Account>();
    	Integer numType = 0;
    	for(String typez: type_lst){
		    for(Integer i=0;i<accTypeCount_map.get(typez);i++){
			 	acc_lst.add(new Account(
		            Name = 'TestAcc'+i+numType,
		            Core_Firm_Email__c = typez+'@cr7.siu.12champions.com.dev'+i+numType,
		            Core_NIF__c = String.valueOf(i+numType).leftPad(6, '0')+generateRandomString(1,false,true,false,false),
		            Core_idenPN_PK__c = (typez=='Cliente'||typez=='Ex-cliente')?String.valueOf(i+numType).leftPad(11, '0'):null,
		            Core_Medofi_PK__c = (typez=='Prospect')?String.valueOf(i+numType).leftPad(6, '0'):null,
		            Type = typez
	        	));
		    }
    		numType++;
    	}
    	
    	if(toInsert)
    		insert acc_lst;
    		
        Map<String,List<Account>> typeAcc_map = new Map<String,List<Account>>();
		for(Account acc: acc_lst){
			if(typeAcc_map.containsKey(acc.Type)){
				List<Account> aux = typeAcc_map.get(acc.Type);
				aux.add(acc);
				typeAcc_map.put(acc.Type,aux);
			}
			else {
				typeAcc_map.put(acc.Type,new List<Account>{acc});
			}
		}
		
		return typeAcc_map;
    }
    
    @testVisible
    private static Map<Id,List<Opportunity>> createOpportunityBulk(Boolean toInsert, List<Id> accId_lst, List<Integer> numOpp_lst, List<String> branch_lst, List<Core_Commercial_Pyramid__c> comPyr_lst){
    	Map<Id,Integer> accIdNumOpp_map = new Map<Id,Integer>();
    	for(Integer i=0;i<accId_lst.size();i++){
    		accIdNumOpp_map.put(accId_lst[i],numOpp_lst[i]);
    	}
    	
    	List<Opportunity> opp_lst = new List<Opportunity>();
    	Integer numAccId = 0;
    	for(Integer i=0;i<accId_lst.size();i++){
    		Integer measurer = 0;
    		for(Integer j=0;j<accIdNumOpp_map.get(accId_lst[i]);j++){
    			if(measurer> branch_lst.size() -1){
    				measurer = 0;
    			}
                if(!comPyr_lst.isEmpty()){
                        opp_lst.add(new Opportunity(
                        Name = 'TestOpp'+i+numAccId,
                        Core_Account__c = accId_lst[i],
                        CloseDate = system.today()+i+numAccId,
                        StageName = 'Qualification',
                        Core_Branch__c = branch_lst[measurer],
                        Core_Billing_Postal_Code__c = ('28'+i+numAccId).rightPad(5,'0').substring(0,5),
                        Core_Medofi_PK__c = comPyr_lst[i].Core_Medofi_PK__c,
                        Core_Medofi__c = comPyr_lst[i].Id,
                        //Core_Initial_Client_Type__c = 'Cliente',
                        Core_Status_Contacted__c = '1',    
                        Core_IdenPN_PK__c = '00000000000'
     
                    ));
                    measurer ++;
                }
                else{
                    opp_lst.add(new Opportunity(
                        Name = 'TestOpp'+i+numAccId,
                        Core_Account__c = accId_lst[i],
                        CloseDate = system.today()+i+numAccId,
                        StageName = 'Qualification',
                        Core_Branch__c = branch_lst[measurer],
                        Core_Billing_Postal_Code__c = ('35'+i+numAccId).rightPad(5,'0').substring(0,5),
                        //Core_Initial_Client_Type__c = 'Prospect',
                        Core_Status_Contacted__c = '1',
                        Core_IdenPN_PK__c = '00000000000'
                    ));
                    measurer ++;
                }
    			
    		}
    		numAccId++;
    	}
    	
    	if(toInsert)
    		insert opp_lst;
    		
    	Map<Id,List<Opportunity>> accIdOpp_map = new Map<Id,List<Opportunity>>();
    	for(Opportunity opp: opp_lst){
    		if(accIdOpp_map.containsKey(opp.Core_Account__c)){
    			List<Opportunity> aux = accIdOpp_map.get(opp.Core_Account__c);
    			aux.add(opp);
    			accIdOpp_map.put(opp.Core_Account__c,aux);
    		}
    		else {
    			accIdOpp_map.put(opp.Core_Account__c,new List<Opportunity>{opp});
    		}
    	}
    	
    	return accIdOpp_map;
    }
    
    @testVisible
    private static Map<Id,List<Core_Policy__c>> createPolicyBulk(Boolean toInsert, List<Id> accId_lst, List<Integer> numPol_lst, List<String> status_lst, List<String> medofi_lst){
    	
    	Map<Id,Integer> accIdNumPol_map = new Map<Id,Integer>();
        
    	for(Integer i=0;i<accId_lst.size();i++){
    		accIdNumPol_map.put(accId_lst[i],numPol_lst[i]);
    	}

    	List<Core_Policy__c> policy_lst = new List<Core_Policy__c>();
    	Integer numAccId = 0;
    	for(Id idAux: accId_lst){
    		for(Integer i=0;i<accIdNumPol_map.get(idAux);i++){
    			policy_lst.add(new Core_Policy__c(
		            Name = 'TestPolicy'+i+numAccId, 
		            Core_Account__c = idAux,
		            Core_Medofi_PK__c = (medofi_lst.size()>=numAccId)?String.valueOf(i+numAccId).rightPad(6,'0').substring(0,6):medofi_lst[i],
		        	Core_Status__c = status_lst[numAccId],
                    Core_IdenPN_PK__c = '00000000000',
                    Core_Product_PK__c = '1234',
                    Core_Release_Date__c = date.today() -1,
                    Core_First_Release_Date__c = Date.newInstance(2018, 2, 17)
                    
		        ));
    		}
    		numAccId++;
    	}
    	if(toInsert)
    		insert policy_lst;
    		
    	Map<Id,List<Core_Policy__c>> accIdPol_map = new Map<Id,List<Core_Policy__c>>();    	
    	for(Core_Policy__c pol: policy_lst){
    		if(accIdPol_map.containsKey(pol.Core_Account__c)){
    			List<Core_Policy__c> aux = accIdPol_map.get(pol.Core_Account__c);
    			aux.add(pol);
    			accIdPol_map.put(pol.Core_Account__c,aux);
    		}
    		else {
    			accIdPol_map.put(pol.Core_Account__c,new List<Core_Policy__c>{pol});    			
    		}
    	}
    	
    	return accIdPol_map;
    }
    
    @testVisible
    private static Map<Id,List<Core_Competitive_Information__c>> createCompetitiveInfoBulk(Boolean toInsert, List<Account> acc_lst, List<Integer> numCompetitveInfo_lst, List<String> type_lst, List<String> medofi_lst){
    	
    	Map<Id,Integer> accIdNumCompInfo_map = new Map<Id,Integer>();
    	for(Integer i=0;i<acc_lst.size();i++){
    		accIdNumCompInfo_map.put(acc_lst[i].Id,numCompetitveInfo_lst[i]);
    	}
    	
    	List<Core_Competitive_Information__c> competitiveInfo_lst = new List<Core_Competitive_Information__c>();
    	Integer numAccId = 0;
    	for(Account acc: acc_lst){
            Integer j = 0;
    		for(Integer i=0;i<accIdNumCompInfo_map.get(acc.Id);i++){
                if(type_lst[j] == '2'){
                    competitiveInfo_lst.add(new Core_Competitive_Information__c(
		            	Core_Account__c = acc.Id,
                    	Core_Medofi_PK__c = (medofi_lst.size()>=numAccId)?String.valueOf(i+numAccId).rightPad(6,'0').substring(0,6):medofi_lst[i],
		        		Core_idenPN_PK__c = acc.Core_idenPN_PK__c
		        	)); 
                }
                else if(type_lst[j] == '3'){
                    competitiveInfo_lst.add(new Core_Competitive_Information__c(
		            	Core_Account__c = acc.Id
		        	)); 
                }
    		}
            j++;
    		numAccId++;
    	}
        
    	if(toInsert)
    		insert competitiveInfo_lst;
    		
    	Map<Id,List<Core_Competitive_Information__c>> competitiveInfo_map = new Map<Id,List<Core_Competitive_Information__c>>();    	
    	for(Core_Competitive_Information__c compInfo: competitiveInfo_lst){
    		if(competitiveInfo_map.containsKey(compInfo.Core_Account__c)){
    			List<Core_Competitive_Information__c> aux = competitiveInfo_map.get(compInfo.Core_Account__c);
    			aux.add(compInfo);
    			competitiveInfo_map.put(compInfo.Core_Account__c,aux);
    		}
    		else {
    			competitiveInfo_map.put(compInfo.Core_Account__c,new List<Core_Competitive_Information__c>{compInfo});    			
    		}
    	}
    	
    	return competitiveInfo_map;
    }
    
    @testVisible
	private static Map<Id,List<AccountHistory>> createAccHistoryBulk(Boolean toInsert, List<Id> accId_lst, List<List<String>> fieldlst_lst){
    	List<AccountHistory> accHistory_lst = new List<AccountHistory>();
    	for(Integer i=0;i<accId_lst.size();i++){
    		for(String field: fieldlst_lst[i]){
    			accHistory_lst.add(new AccountHistory(
    				AccountId = accId_lst[i],
    				Field = field
    			));
    		}
    	}
    	
    	if(toInsert)
    		insert accHistory_lst;
    	
    	Map<Id,List<AccountHistory>> accIdHistory_map = new Map<Id,List<AccountHistory>>();
    	for(AccountHistory accHis: accHistory_lst){
    		if(accIdHistory_map.containsKey(accHis.AccountId)){
    			List<AccountHistory> aux = accIdHistory_map.get(accHis.AccountId);
    			aux.add(accHis);
    			accIdHistory_map.put(accHis.AccountId,aux);
    		}
    		else {
    			accIdHistory_map.put(accHis.AccountId,new List<AccountHistory>{accHis});
    		}
    	}
    	
    	return accIdHistory_map;
    }
    
    @testVisible
	private static List<Group> createGroupsBulk(Boolean toInsert, Integer min, Integer max){
        Integer diff = max-min;
        
        List<Group> group_lst = new List<Group>();
        for(Integer i=0;i<diff;i++){
            String sum = String.valueOf(min+i);
            String fillSixDigits = sum.leftPad(6, '0');
            system.debug('filled: '+fillSixDigits);
            group_lst.add(new Group(
                Name = 'GP_'+fillSixDigits+'_'+fillSixDigits+'_'+fillSixDigits+'_'+fillSixDigits.substring(2,6)+'_'+fillSixDigits.substring(4,6)+'_'+fillSixDigits.substring(4,6)+'_'+fillSixDigits.substring(4,6),
                DeveloperName = 'GP_'+fillSixDigits+'_'+fillSixDigits+'_'+fillSixDigits+'_'+fillSixDigits.substring(2,6)+'_'+fillSixDigits.substring(4,6)+'_'+fillSixDigits.substring(4,6)+'_'+fillSixDigits.substring(4,6)
            ));
        }
        
        if(toInsert)
            insert group_lst;
        
        return group_lst;
    }
    
    @testVisible
    private static List<GroupMember> createGroupMembersBulk(Boolean toInsert, List<Group> grp_lst, List<Core_Role__c> role_lst){
    		
		Map<String,List<Group>> map_grp_medofi      = new Map<String,List<Group>>();
        Map<String,List<Group>> map_grp_medor       = new Map<String,List<Group>>();
        Map<String,List<Group>> map_grp_gesCom      = new Map<String,List<Group>>();
        Map<String,List<Group>> map_grp_office      = new Map<String,List<Group>>();
        Map<String,List<Group>> map_grp_zone        = new Map<String,List<Group>>();
        Map<String,List<Group>> map_grp_territory   = new Map<String,List<Group>>();
        Map<String,List<Group>> map_grp_network     = new Map<String,List<Group>>();
        
        for(Group grp: grp_lst) {          
          //POSITION 0 OF LIST: GP, useless
          List<String> name_lst = grp.DeveloperName.split('_');
          
          if(map_grp_medofi.containsKey(name_lst[1])) {
            List<Group> aux = map_grp_medofi.get(name_lst[1]);
            aux.add(grp);
            map_grp_medofi.put(name_lst[1],aux);
          }
          else {
            map_grp_medofi.put(name_lst[1],new List<Group>{grp});
          }
          
          if(map_grp_medor.containsKey(name_lst[2])) {
            List<Group> aux = map_grp_medor.get(name_lst[2]);
            aux.add(grp);
            map_grp_medor.put(name_lst[2],aux);
          }
          else {
            map_grp_medor.put(name_lst[2],new List<Group>{grp});
          }
            
          if(map_grp_gesCom.containsKey(name_lst[3])) {
            List<Group> aux = map_grp_gesCom.get(name_lst[3]);
            aux.add(grp);
            map_grp_gesCom.put(name_lst[3],aux);
          }
          else {
            map_grp_gesCom.put(name_lst[3],new List<Group>{grp});
          }
                      
          if(map_grp_office.containsKey(name_lst[4])) {
            List<Group> aux = map_grp_office.get(name_lst[4]);
            aux.add(grp);
            map_grp_office.put(name_lst[4],aux);
          }
          else {
            map_grp_office.put(name_lst[4],new List<Group>{grp});
          }
                      
          if(map_grp_zone.containsKey(name_lst[5])) {
            List<Group> aux = map_grp_zone.get(name_lst[5]);
            aux.add(grp);
            map_grp_zone.put(name_lst[5],aux);
          }
          else {
            map_grp_zone.put(name_lst[5],new List<Group>{grp});
          }
                        
          if(map_grp_territory.containsKey(name_lst[6])) {
            List<Group> aux = map_grp_territory.get(name_lst[6]);
            aux.add(grp);
            map_grp_territory.put(name_lst[6],aux);
          }
          else {
            map_grp_territory.put(name_lst[6],new List<Group>{grp});              
          }
            
          if(map_grp_network.containsKey(name_lst[7])) {
            List<Group> aux = map_grp_network.get(name_lst[7]);
            aux.add(grp);
            map_grp_network.put(name_lst[7],aux);
          }
          else {
            map_grp_network.put(name_lst[7],new List<Group>{grp});              
          }
        }
        
        //MAPA DE CONTROL DE ERRORES
        Map<Id,Core_Role__c> updRole_map = new Map<Id,Core_Role__c>();
        List<GroupMember> grpMem_lst = new List<GroupMember>();
        Integer measurer = 0;
    
        for(Core_Role__c role: role_lst){
          List<Group> grpAux_lst = new List<Group>();
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidMedofiExternalCode
          && map_grp_medofi.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_medofi.get(role.Core_Pyramid_Value__c);
          }
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidMedorExternalCode
          && map_grp_medor.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_medor.get(role.Core_Pyramid_Value__c);
          }
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidGesComExternalCode
          && map_grp_gesCom.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_gesCom.get(role.Core_Pyramid_Value__c);
          }
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidOfficeExternalCode
          && map_grp_office.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_office.get(role.Core_Pyramid_Value__c);
          }
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidZoneExternalCode
          && map_grp_zone.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_zone.get(role.Core_Pyramid_Value__c);
          }
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidTerritoryExternalCode
          && map_grp_territory.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_territory.get(role.Core_Pyramid_Value__c);
          }
          
          if(role.Core_Pyramid_Level__c==Label.CommercialPyramidNetworkExternalCode
          && map_grp_network.containsKey(role.Core_Pyramid_Value__c)){
            grpAux_lst = map_grp_network.get(role.Core_Pyramid_Value__c);
          }
          
          if(!grpAux_lst.isEmpty()){
            for(Group grp: grpAux_lst){
              grpMem_lst.add(new GroupMember(
                GroupId = grp.Id,
                UserOrGroupId = role.Core_User__c
              ));
            }
          }
        }
        
        if(toInsert)
        	insert grpMem_lst;
        
        return grpMem_lst;
 	}
    
    @testVisible
    private static List<Core_Commercial_Pyramid__c> createComPyramidBulk(Boolean toInsert, Integer min, Integer max){
        Integer diff = max-min;
        
        List<Core_Commercial_Pyramid__c> comPyr_lst = new List<Core_Commercial_Pyramid__c>();
        for(Integer i=0;i<diff;i++){
            String sum = String.valueOf(min+i);
            String fillSixDigits = sum.leftPad(6, '0');
            comPyr_lst.add(new Core_Commercial_Pyramid__c(
                Name = fillSixDigits,
                Core_Medofi_PK__c = fillSixDigits,
                Core_Medor__c = fillSixDigits,
                Core_Commercial_Manager__c = fillSixDigits,
                Core_Office__c = fillSixDigits.substring(2,6),
                Core_Zone__c = fillSixDigits.substring(4,6),
                Core_Territory__c  = fillSixDigits.substring(4,6),
                Core_Network__c   = fillSixDigits.substring(4,6),        
                Core_Status__c  = true,
                Core_Last_Modified_Date_Network__c = System.today(),
                Core_Processing_Status__c = Label.CommercialPyramidPendingProcessing            
            ));
        }
        
        Core_Commercial_Pyramid__c eof = new Core_Commercial_Pyramid__c(
            Name = 'Medofi',
            Core_Medofi_PK__c = 'Medofi',
            Core_Medor__c = 'EOF',
            Core_Commercial_Manager__c = 'Gestor',
            Core_Office__c = 'Ofic',
            Core_Zone__c = 'Zo',
            Core_Territory__c  = 'Te',
            Core_Network__c	 = 'Re',         
            Core_Status__c  = true,
            Core_Last_Modified_Date_Network__c = system.today(),
            Core_Processing_Status__c = label.CommercialPyramidPendingProcessing
        );
        
        comPyr_lst.add(eof);
        system.debug('++++TestCommercialPyramid' + comPyr_lst);
        if(toInsert)
          insert comPyr_lst;

        update new List<Core_Commercial_Pyramid__c>{eof};
        return comPyr_lst;
    }
    
    @testVisible
    private static List<Core_Role__c> createRolesBulk(Boolean toInsert, List<User> usr_lst, List<Group> group_lst, List<String> pyrLevel_lst){
        List<Core_Role__c> role_lst = new List<Core_Role__c>();
        Core_Role__c eof = new Core_Role__c();
        List<String> pyrValue_List = new List<String>();
        
            for (integer i=0; i<group_lst.size(); i++){
               String pyrValue = group_lst[i].developerName;
                if (pyrLevel_lst[i] == '02'){ 
                    pyrValue_List.add(pyrValue.substring(32,34));
                }else if (pyrLevel_lst[i] == '03'){ 
                    pyrValue_List.add(pyrValue.substring(29,31));
                }else if (pyrLevel_lst[i] == '04'){
                    pyrValue_List.add(pyrValue.substring(24,28));
                }else if (pyrLevel_lst[i] == '05'){
                    pyrValue_List.add(pyrValue.substring(3,9));
                }else if (pyrLevel_lst[i] == '06'){
                    pyrValue_List.add(pyrValue.substring(17,23));
                }else if (pyrLevel_lst[i] == '07'){
                    pyrValue_List.add(pyrValue.substring(35,37));
                }else if (pyrLevel_lst[i] == '08'){
                    pyrValue_List.add(pyrValue.substring(10,16));
                }
            }
        System.debug('FML pyrValue_List: ' +pyrValue_List);
        
        Integer eofPos = 0;
        if (usr_lst.size()>0){
            eofPos = usr_lst.size()-1;
        }

      for(Integer i=0;i<group_lst.size();i++){
            role_lst.add(new Core_Role__c(
                Core_User__c = usr_lst[i].Id,
                Core_User_PK__c = usr_lst[i].Core_User_PK__c,
                Core_Pyramid_Level__c = pyrLevel_lst[i],
                Core_Pyramid_Value__c = pyrValue_List[i],
                Core_Role_PK__c = usr_lst[i].Core_User_PK__c+pyrLevel_lst[i]+pyrValue_List[i],
                Core_Status__c = true,
                Core_Processing_Status__c = Label.CommercialPyramidPendingProcessing
            ));
            
        }
                eof = new Core_Role__c(
                Core_User__c = usr_lst[eofPos].Id,
                Core_User_PK__c = usr_lst[eofPos].Core_User_PK__c,
                Core_Pyramid_Level__c = '08',
                Core_Pyramid_Value__c = 'EOF',
                Core_Role_PK__c = 'EOF08EOF',
                Core_Status__c = true     
            );
            
            role_lst.add(eof);
                
        insert role_lst;
        update new List<Core_Role__c>{eof};
        return role_lst;
    }
    /*private static List<Core_Role__c> createRolesBulk(Boolean toInsert, List<User> usr_lst, List<Group> group_lst){
        List<Core_Role__c> role_lst = new List<Core_Role__c>();
        Core_Role__c eof = new Core_Role__c();
        Map<Integer,Integer> mapPyrValuePos_map = new Map<Integer,Integer>{
            2 => 6,
            3 => 5,
            4 => 4,
            5 => 1,
            6 => 3,
            7 => 7,
            8 => 2
        };

        Integer measurer = 2;
        Integer eofPos = null;
        
        for(Integer i=0;i<usr_lst.size();i++){
            //if(usr_lst[i].Profile.Name=='System Integration Role'){
                eofPos = i;
                //continue;
            //}
            
            if(measurer>8)
                measurer = 2;

            role_lst.add(new Core_Role__c(
                Core_User__c = usr_lst[i].Id,
                Core_User_PK__c = usr_lst[i].Core_User_PK__c,
                Core_Pyramid_Level__c = '0'+measurer,
                Core_Pyramid_Value__c = group_lst[i].DeveloperName.split('_')[mapPyrValuePos_map.get(measurer)],
                Core_Role_PK__c = usr_lst[i].Core_User_PK__c+'0'+measurer+group_lst[i].DeveloperName.split('_')[mapPyrValuePos_map.get(measurer)],
                Core_Status__c = true,
                Core_Processing_Status__c = Label.CommercialPyramidPendingProcessing
            ));
            measurer++;
        }
        
                eof = new Core_Role__c(
                Core_User__c = usr_lst[eofPos].Id,
                Core_User_PK__c = usr_lst[eofPos].Core_User_PK__c,
                Core_Pyramid_Level__c = '08',
                Core_Pyramid_Value__c = 'EOF',
                Core_Role_PK__c = 'EOF08EOF',
                Core_Status__c = true     
            );
            
            role_lst.add(eof);
                
        insert role_lst;
        update new List<Core_Role__c>{eof};
        return role_lst;
    }*/
    
    @testVisible
    private static List<Core_Group_Management__c> createGroupManagementBulk(Boolean toInsert, List<Group> grp_lst){
        List<Core_Group_Management__c> grpMgmt_lst = new List<Core_Group_Management__c>();
        for(Group grp: grp_lst){
            grpMgmt_lst.add(new Core_Group_Management__c(
                Core_Old_Group_Label__c = grp.DeveloperName,
                Core_New_Group_Label__c = grp.DeveloperName.replaceAll('0','1'),
                Core_Group_Id__c = grp.Id,
                Core_Processing_Status__c = Label.CommercialPyramidPendingProcessing
            ));
        }
        
        if(toInsert)
            insert grpMgmt_lst;
            
        return grpMgmt_lst;
    }
    
    @testVisible
    private static List<CS_BatchConfiguration__c> createBatchConfigurationBulk(Boolean toInsert, List<String> recordName_lst, List<Boolean> active_lst, List<Integer> minutes_lst){
        List<CS_BatchConfiguration__c> batchConfig_lst = new List<CS_BatchConfiguration__c>();
        for(Integer i=0; i<recordName_lst.size();i++){
	        batchConfig_lst.add(new CS_BatchConfiguration__c(
	            Name = recordName_lst[i],
	            Core_Active__c = active_lst[i], 
	            Core_AddMinutesBatch__c = minutes_lst[i]
	        ));
        }
        
        if(toInsert)
        	insert batchConfig_lst;
        
        return batchConfig_lst;
    }
    
    @testVisible
    private static List<Core_PostalCodes__c> createPostalCodes(Boolean toInsert, List<String> name_lst, List<String> provinceCode_lst){
    	List<Core_PostalCodes__c> postalCode_lst = new List<Core_PostalCodes__c>();
    	for(Integer i=0;i<name_lst.size();i++){
	    	postalCode_lst.add(new Core_PostalCodes__c(
	 			Name = name_lst[i],
	        	Core_ProvinceCode__c = provinceCode_lst[i]
	        ));
    	}
    	
    	if(toInsert)
    		insert postalCode_lst;
    		
    	return postalCode_lst;
    }
    
    @testVisible
	private static List<Core_PostalCode_Assignment__c> createPostalCodeAssignBulk(Boolean toInsert, List<Core_Commercial_Pyramid__c> comPyr_lst, List<Core_PostalCodes__c> postalCode_lst, List<Decimal> assignOrder){
        
        List<Core_PostalCode_Assignment__c> postalCodeAssign_lst = new List<Core_PostalCode_Assignment__c>();
        for(Integer i=0;i<comPyr_lst.size();i++){
        	postalCodeAssign_lst.add(new Core_PostalCode_Assignment__c(
	        	Core_Medofi__c = comPyr_lst[i].Id,
	            Core_Medofi_PK__c = comPyr_lst[i].Core_Medofi_PK__c,
	            Core_Postal_Code__c = postalCode_lst[i].Id,
	            Core_Assigned_Order__c = assignOrder[i],
	            Core_LifeTrade__c = true,
	            Core_HealthTrade__c = true,
	            Core_MotorTrade__c = true
	        ));
        }
        
        if(toInsert)
        	insert postalCodeAssign_lst;
            
        return postalCodeAssign_lst;
    }
    
	@testVisible
    private static List<Database.SaveResult> createDDBBSaveResult(Integer num, Boolean success){
    	List<Account> acc_lst = new List<Account>();
    	for(Integer i=0;i<num;i++){
    		Account acc = new Account(
    			LastName = 'testAcc'+i
    		);
    		
    		acc_lst.add(acc);
    	}
    	
    	List<Database.SaveResult> dsr_lst = Database.insert(acc_lst,false);
    	
    	if(success){
    		return dsr_lst;
    	}
    	else {
    		for(Account acc: acc_lst){
    			acc.LastName = null;
    		}
    		
    		return Database.update(acc_lst,false);
    	}
    }
    
    @testVisible
    private static List<Database.DeleteResult> createDDBBDeleteResult(Integer num, Boolean success){
    	List<Core_Commercial_Pyramid__c> comPyr_lst = new List<Core_Commercial_Pyramid__c>();
    	for(Integer i=0;i<num;i++){
    		Core_Commercial_Pyramid__c comPyr = new Core_Commercial_Pyramid__c();
    		if(success){
    			comPyr = new Core_Commercial_Pyramid__c(
	    			Name 						= String.valueOf(i+i+i+i+i+i),
	                Core_Medofi_PK__c 			= String.valueOf(i+i+i+i+i+i),
	                Core_Medor__c 				= String.valueOf(i+i+i+i+i+i),
	                Core_Commercial_Manager__c 	= String.valueOf(i+i+i+i+i+i),
	                Core_Office__c 				= String.valueOf(i+i+i+i),
	                Core_Zone__c 				= String.valueOf(i+i),
	                Core_Territory__c  			= String.valueOf(i+i),
	                Core_Network__c   			= String.valueOf(i+i),        
	                Core_Status__c  			= true,
	                Core_Last_Modified_Date_Network__c = System.today(),
	                Core_Processing_Status__c = Label.CommercialPyramidPendingProcessing
	           );
    		}
    	}
    	
    	return Database.delete(comPyr_lst,false);
    }
    
    @testVisible
    private static List<CS_OpportunitiesAssignment__c> createCSOpportunitiesAssignmentBulk(Boolean toInsert, List<String> name_lst, List<String> branch_lst){
        List<CS_OpportunitiesAssignment__c> csOppAssign_lst = new List<CS_OpportunitiesAssignment__c>();
        for(Integer i=0; i<name_lst.size(); i++){
	        csOppAssign_lst.add(new CS_OpportunitiesAssignment__c(
                Name = name_lst[i],
                Core_Identifier__c = name_lst[i].right(3),
	            Core_Branch__c = branch_lst[i],
            	Canal_Mediado__c = 75.0,
            	Plataforma_Externa__c = 25.0,
            	Plataforma_Interna__c = 0.0
	        ));
        }
        
        if(toInsert)
        	insert csOppAssign_lst;
        
        return csOppAssign_lst;
    }
    
    public static String generateRandomString(Integer length, Boolean useNumbers, Boolean useMayus, Boolean useMinus, Boolean useSpecialChars) {
    	String numbers = '0123456789';
    	String mayusLetters = 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';
    	String minusLetters = 'abcdefghijklmnñopqrstuvwxyz';
    	String specialChars = 'ÜÖÄËÏüöïäëª!"·$%&/()=?¿º|@#~€¬¡¿?¡ÀÈÌÒÙ^*¨Ç`+´ç,.-;:_<>ÁÉÍÓÚ';
    	String randomize;
    	if(useNumbers){
    		randomize += numbers;
    	}
    	if(useMayus){
    		randomize += mayusLetters;	
    	}
    	if(useMinus){
    		randomize += minusLetters;
    	}
    	if(useSpecialChars){
    		randomize += specialChars;
    	}
    	Integer randomizeLength = randomize.length();
    	
    	String randStr = '';
        for(Integer i=0;i<length;i++){
        	Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), randomizeLength);
       		randStr += randomize.substring(idx, idx+1);
        }
        
        return randStr;
    }
    
    public static List<Campaign> createCampaignBulk(Integer length) {
		List <Campaign> campaignToInsert = new List<Campaign>();
		Date hoy = Date.today();
		String mes = '';
        Integer intMes;
        Integer intAno;
		
		for(Integer i = 0; i<length; i++){
            if(hoy.month() == 12){
                intMes = 1;
                intAno = hoy.year()+1;
            } else{
                intMes = hoy.month()+i;
                intAno = hoy.year();
            }
            
            mes = String.valueOf(intMes);
			if(mes.length()==1){
				mes = '0'+mes;
			}
            Integer numberOfDays = Date.daysInMonth(intAno, intMes);
            Date firstDayOfMonth = Date.newInstance(intAno, intMes, 1);
			Date lastDayOfMonth = Date.newInstance(intAno, intMes, numberOfDays);
			campaignToInsert.add(new Campaign(
											Name = 'GENE'+String.valueOf(intAno).substring(2)+mes,
											EndDate=lastDayOfMonth,
                							StartDate=firstDayOfMonth,
											Core_Branch__c = '2',
											Core_Campaign_Code__c = 'GENE'+String.valueOf(intAno).substring(2)+mes
											));
			campaignToInsert.add(new Campaign(
											Name = 'PM'+String.valueOf(intAno).substring(2)+mes,
											EndDate=lastDayOfMonth,
                							StartDate=firstDayOfMonth,
											Core_Branch__c = '2',
											Core_Campaign_Code__c = 'PM'+String.valueOf(intAno).substring(2)+mes
											));
			campaignToInsert.add(new Campaign(
											Name = 'LD'+mes+String.valueOf(intAno).substring(2),
											EndDate=lastDayOfMonth,
                							StartDate=firstDayOfMonth,
											Core_Branch__c = '2',											
                							Core_Campaign_Code__c = 'LD'+mes+String.valueOf(intAno).substring(2)
											));
			hoy = hoy +30;
		}
		
		System.debug('###Paco campaignToInsert: '+ campaignToInsert);
		
		insert campaignToInsert;
				
        return campaignToInsert;
    }
    
    public static List<Core_Competitive_Information__c> createCompetitiveInformation(Integer length, Account acc) {
		List <Core_Competitive_Information__c> competitiveToInsert = new List<Core_Competitive_Information__c>();
		Date hoy = Date.today();
		
		for(Integer i = 0; i<length; i++){
			competitiveToInsert.add(new Core_Competitive_Information__c(
											Core_Account__c=acc.id,
											Core_Expiration_Date__c = hoy+60,
											Core_Branch__c = '2'
											));
			
		}

		insert competitiveToInsert;
				
        return competitiveToInsert;
    }
    
    public static void createCriptoCSAES256 (){
    	insert new CS_Cripto_Utils__c(
    		Name = 'AES256',
    		IV__c = '0000000000000000',
    		KEY__c = '<`4G"kR2w%;Gwu5+jvE9?UGcETj,dc2&');
    }
    
}