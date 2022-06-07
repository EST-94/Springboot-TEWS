package com.example.tews;

import java.math.BigInteger;
import java.rmi.RemoteException;
import java.util.Arrays;
import javax.xml.rpc.ServiceException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

import com.example.VO.UserVO;

import tews6.wsdl.CreateUser;
import tews6.wsdl.CreateUserProfileTab;
import tews6.wsdl.CreateUserSearch;
import tews6.wsdl.CreateUserSearchOrganization;
import tews6.wsdl.DeleteUser;
import tews6.wsdl.DeleteUserDeleteTab;
import tews6.wsdl.DeleteUserSearch;
import tews6.wsdl.DeleteUserSearchFilter;
import tews6.wsdl.ImsException;
import tews6.wsdl.ImsStatus;

import tews6.wsdl.ModifyUser;
import tews6.wsdl.ModifyUserProfileTab;
import tews6.wsdl.ModifyUserSearch;
import tews6.wsdl.ModifyUserSearchFilter;
import tews6.wsdl.OperatorType;
import tews6.wsdl.TaskContext;
import tews6.wsdl.Tews6Locator;
import tews6.wsdl.Tews6PortType;
import tews6.wsdl.Tews6SoapBindingStub;

@Service
@ComponentScan(basePackages = {"com.example.VO"})
public class TewsServiceImpl implements TewsService {
	
	private static Logger logger = LoggerFactory.getLogger(TewsService.class);
	
	public boolean tewsCreateUser(UserVO userVO) throws ServiceException, ImsException, RemoteException {
		
		logger.debug("tewsService - TEWS user Create started.");
		
		String adminID = "imadmin";
		String password = "Qwe123asd!";
		
		boolean tewsReturn = false;
		
		Tews6Locator tews6Locator = new Tews6Locator();
		Tews6PortType tews6PortType = tews6Locator.getTews6Port();
		logger.debug("Tews6PortAddress : " + tews6Locator.getTews6PortAddress());

		Tews6SoapBindingStub stub = (Tews6SoapBindingStub) tews6PortType;
		stub.setUsername(adminID);
		stub.setPassword(password);
		stub.setMaintainSession(true);
		stub._setProperty("Cookie", "SMCHALLENGE=YES");
		
		// connection informations are set
		// need to call 'create' task down below
		
		CreateUser createUser = new CreateUser();
		CreateUserSearch createUserSearch = new CreateUserSearch();
		CreateUserProfileTab createUserProfileTab = new CreateUserProfileTab();
		
		createUserSearch.setCreateNew(new Boolean(true));
		
		
			// set the org of user
		CreateUserSearchOrganization createUserSearchOrgnation = new CreateUserSearchOrganization();
		createUserSearchOrgnation.setUniqueName("ou=im,ou=ca,o=com");
		createUserSearch.setOrganization(createUserSearchOrgnation);
		createUser.setCreateUserSearch(createUserSearch);
		
			// set the org via profile Tab
		createUserProfileTab.set_PCT_ORG_MEMBERSHIP_PCT_("ou=im,ou=ca,o=com");
		
		
			// set my values
		if(userVO.getUserid() != null && !("").equals(userVO.getUserid())) {
			logger.info("From TewsServiceImpl - USERID set as : " + userVO.getUserid());
			createUserProfileTab.set_PCT_USER_ID_PCT_(userVO.getUserid());
		} else {
			logger.error("From TewsServiceImpl - USERID values wrong. : " + userVO.getUserid());
			createUserProfileTab.set_PCT_USER_ID_PCT_("");
		}
		
		if(userVO.getFirstname() != null && !("").equals(userVO.getFirstname())) {
			logger.info("From TewsServiceImpl - FIRSTNAME set as : " + userVO.getFirstname());
			createUserProfileTab.set_PCT_FIRST_NAME_PCT_(userVO.getFirstname());
		} else {
			logger.error("From TewsServiceImpl - FIRSTNAME values wrong. : " + userVO.getFirstname());
			createUserProfileTab.set_PCT_FIRST_NAME_PCT_("");
		}
		
		if(userVO.getLastname() != null && !("").equals(userVO.getLastname())) {
			logger.info("From TewsServiceImpl - LASTNAME set as : " + userVO.getLastname());
			createUserProfileTab.set_PCT_LAST_NAME_PCT_(userVO.getLastname());
		} else {
			logger.error("From TewsServiceImpl - LASTNAME values wrong. : " + userVO.getLastname());
			createUserProfileTab.set_PCT_LAST_NAME_PCT_("");
		}
			
		if(userVO.getFullname() != null && !("").equals(userVO.getFullname())) {
			logger.info("From TewsServiceImpl - FULLNAME set as : " + userVO.getFullname());
			createUserProfileTab.set_PCT_FULL_NAME_PCT_(userVO.getFullname());
		} else {
			logger.error("From TewsServiceImpl - FULLNAME values wrong. : " + userVO.getFullname());
			createUserProfileTab.set_PCT_FULL_NAME_PCT_("");
		}
		
		
		createUser.setCreateUserProfileTab(createUserProfileTab);
		
		// task body ends
		
		// wrapup my context
		
		TaskContext taskContext = new TaskContext();
		taskContext.setAdmin_id(adminID);
		taskContext.setAdmin_password(password);
		
		ImsStatus imsStatus = null;
		
		// execute TEWS
		
		imsStatus = tews6PortType.createUser(taskContext, createUser);
		String taskId = checkStatus(imsStatus);
		if (taskId != null && !("").equals(taskId)) {
			logger.info("Task ID : " + taskId + ", Subject Name : " + userVO.getUserid());
			tewsReturn = true;
		}
		
		logger.info("Run TEWS : TASK_CreateUser done");
		
		return tewsReturn;
	}

	public boolean tewsModifyUser(UserVO userVO) throws Exception {
		
		logger.debug("tewsService - TEWS user Modify started.");
		
		String adminID = "imadmin";
		String password = "Qwe123asd!";
		
		boolean tewsReturn = false;
		
		Tews6Locator tews6Locator = new Tews6Locator();
		Tews6PortType tews6PortType = tews6Locator.getTews6Port();
		logger.debug("Tews6PortAddress : " + tews6Locator.getTews6PortAddress());

		Tews6SoapBindingStub stub = (Tews6SoapBindingStub) tews6PortType;
		stub.setUsername(adminID);
		stub.setPassword(password);
		stub.setMaintainSession(true);
		stub._setProperty("Cookie", "SMCHALLENGE=YES");
		
		// connection informations are set
		
		// need to call 'modifyuser' task down below
		
		ModifyUser modifyUser = new ModifyUser();
		ModifyUserSearch modifyUserSearch = new ModifyUserSearch();
		ModifyUserProfileTab modifyHanonUserProfileTab = new ModifyUserProfileTab();
		
		ModifyUserSearchFilter modifyUserSearchFilter[] = new ModifyUserSearchFilter[1];
		modifyUserSearchFilter[0] = new ModifyUserSearchFilter();
		modifyUserSearchFilter[0].setIndex(new BigInteger("0"));
		modifyUserSearchFilter[0].setField("%USER_ID%");
		modifyUserSearchFilter[0].setOp(OperatorType.EQUALS);
		modifyUserSearchFilter[0].setValue(userVO.getUserid());
		
		modifyUserSearch.setFilter(modifyUserSearchFilter);
		
		modifyUser.setModifyUserSearch(modifyUserSearch);
		modifyUser.setModifyUserProfileTab(modifyHanonUserProfileTab);
		
		// task body ends
		
		// wrapup my context
		
		TaskContext taskContext = new TaskContext();
		taskContext.setAdmin_id(adminID);
		taskContext.setAdmin_password(password);
		
		ImsStatus imsStatus = null;
		
		// execute TEWS
		
		logger.info("Run TEWS : TASK_ModifyUser, User : " + userVO.getUserid());
		
		imsStatus = tews6PortType.modifyUser(taskContext, modifyUser);
		
		String taskId = checkStatus(imsStatus);
		if (taskId != null && !("").equals(taskId)) {
			logger.info("Task ID : " + taskId + ", Subject Name : " + userVO.getUserid());
			tewsReturn = true;
		}
		
		return tewsReturn;
	}
	
	public boolean tewsDeleteUser(UserVO userVO) throws ServiceException, ImsException, RemoteException {
		
		logger.debug("tewsService - TEWS user Delete started. targetUser : " + userVO.getUserid());
		
		String adminID = "imadmin";
		String password = "Qwe123asd!";
		
		boolean tewsReturn = false;
		
		Tews6Locator tews6Locator = new Tews6Locator();
		Tews6PortType tews6PortType = tews6Locator.getTews6Port();
		logger.debug("Tews6PortAddress : " + tews6Locator.getTews6PortAddress());

		Tews6SoapBindingStub stub = (Tews6SoapBindingStub) tews6PortType;
		stub.setUsername(adminID);
		stub.setPassword(password);
		stub.setMaintainSession(true);
		stub._setProperty("Cookie", "SMCHALLENGE=YES");
		
		// connection informations are set
		
			// set the requestBody of delete User
		
		DeleteUser deleteUser = new DeleteUser();
		DeleteUserSearch deleteUserSearch = new DeleteUserSearch();
		DeleteUserDeleteTab deleteUserDeleteTab = new DeleteUserDeleteTab();
		
			// set the filter of search element
		DeleteUserSearchFilter deleteUserSearchFilter[] = new DeleteUserSearchFilter[1];
		deleteUserSearchFilter[0] = new DeleteUserSearchFilter();
		deleteUserSearchFilter[0].setIndex(new BigInteger("0"));
		deleteUserSearchFilter[0].setField("%USER_ID%");
		deleteUserSearchFilter[0].setOp(OperatorType.EQUALS);
		deleteUserSearchFilter[0].setValue(userVO.getUserid());
		
			// associate search filter
		deleteUserSearch.setFilter(deleteUserSearchFilter);
		deleteUser.setDeleteUserDeleteTab(deleteUserDeleteTab);
		
		// task body ends
		
		// wrapup my context
		
		TaskContext taskContext = new TaskContext();
		taskContext.setAdmin_id(adminID);
		taskContext.setAdmin_password(password);
		
		ImsStatus imsStatus = null;
		
		imsStatus = tews6PortType.deleteUser(taskContext, deleteUser);

		String taskId = checkStatus(imsStatus);
		if (taskId != null && !("").equals(taskId)) {
			logger.info("Task ID : " + taskId + ", Subject Name : " + userVO.getUserid());
			tewsReturn = true;
		}
		
		logger.info("Run TEWS : TASK_DeleteUser, User : " + userVO.getUserid());
		
		
		return tewsReturn;
		
	}
	
	public static String checkStatus(ImsStatus status) {
		String taskId = null;

		if (status != null) {
			if (status.getInfoMessage() != null) {
				logger.info("TEWS Version: " + status.getVersion() + ", InfoMessage: " + Arrays.toString(status.getInfoMessage()));
			}

			if (status.getTransactionId() != null) {
				taskId = status.getTransactionId();
				logger.debug("Task ID: " + taskId);
			} else {
				logger.error("Task ID is null");
			}
		} else {
			logger.error("Not able to get Status");
		}

		return taskId;
	}
}
