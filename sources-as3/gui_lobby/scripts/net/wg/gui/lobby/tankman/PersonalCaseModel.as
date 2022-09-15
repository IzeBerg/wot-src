package net.wg.gui.lobby.tankman
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.tankman.vo.PersonalCaseTabNameVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalCaseModel implements IDisposable
   {
       
      
      public var inventoryID:int;
      
      public var iconFile:String = null;
      
      public var rankIconFile:String = null;
      
      public var nativeVehicle:NativeVehicle;
      
      public var firstname:String = null;
      
      public var lastname:String = null;
      
      public var fullName:String = null;
      
      public var rank:String = null;
      
      public var tooltipDismiss:String = "";
      
      public var tooltipUnload:String = "";
      
      public var tooltipChangeRole:String = "";
      
      public var dismissEnabled:Boolean = true;
      
      public var unloadEnabled:Boolean = true;
      
      public var changeRoleEnabled:Boolean = true;
      
      public var hasCommanderFeature:Boolean = false;
      
      public var nationID:int;
      
      public var currentVehicle:PersonalCaseCurrentVehicle = null;
      
      public var specializationLevel:Number;
      
      public var inTank:Boolean = false;
      
      public var role:String = null;
      
      public var roleType:String = null;
      
      public var skills:Array;
      
      public var freeSkills:Array;
      
      public var wg_freeXpToTankman:Boolean = false;
      
      public var enoughFreeXPForTeaching:Boolean;
      
      public var skillsCountForLearn:int = 0;
      
      public var lastNewSkillExp:int = 0;
      
      public var modifiers:Array = null;
      
      public var tabID:String;
      
      public var isBootcamp:Boolean = false;
      
      public var tabsData:Array;
      
      public var actionChangeRole:ActionPriceVO = null;
      
      private var _disposed:Boolean = false;
      
      public function PersonalCaseModel(param1:Object)
      {
         var _loc8_:Object = null;
         var _loc9_:PersonalCaseCurrentVehicle = null;
         this.nativeVehicle = new NativeVehicle();
         this.skills = [];
         this.freeSkills = [];
         this.tabsData = [];
         super();
         this.tabID = param1.tabID;
         this.isBootcamp = Boolean(param1.isBootcamp);
         var _loc2_:Object = param1.nativeVehicle;
         this.nativeVehicle.intCD = _loc2_.intCD;
         this.nativeVehicle.type = _loc2_.type;
         var _loc3_:Object = param1.tankman;
         this.inventoryID = _loc3_.inventoryID;
         this.inTank = _loc3_.isInTank;
         this.nationID = _loc3_.nationID;
         this.iconFile = _loc3_.icon.big;
         this.rankIconFile = _loc3_.iconRank.big;
         this.rank = _loc3_.rankUserName;
         var _loc4_:Object = _loc3_.nativeVehicle;
         var _loc5_:Object = _loc3_.currentVehicle;
         var _loc6_:Object = param1.currentVehicle;
         var _loc7_:Boolean = param1.isOpsLocked;
         this.tooltipDismiss = param1.tooltipDismiss;
         this.tooltipUnload = param1.tooltipUnload;
         this.dismissEnabled = param1.dismissEnabled;
         this.unloadEnabled = param1.unloadEnabled;
         this.changeRoleEnabled = param1.changeRoleEnabled;
         this.hasCommanderFeature = param1.hasCommanderFeature;
         this.tooltipChangeRole = param1.tooltipChangeRole;
         this.actionChangeRole = new ActionPriceVO(param1.actionChangeRole);
         this.nativeVehicle.userName = _loc4_.userName;
         this.nativeVehicle.contourIconFile = _loc4_.iconContour;
         this.nativeVehicle.icon = _loc4_.icon;
         this.firstname = _loc3_.firstUserName;
         this.lastname = _loc3_.lastUserName;
         this.fullName = _loc3_.fullName;
         for each(_loc8_ in param1.tabsData)
         {
            this.tabsData.push(new PersonalCaseTabNameVO(_loc8_));
         }
         if(_loc6_)
         {
            _loc9_ = new PersonalCaseCurrentVehicle();
            this.currentVehicle = _loc9_;
            _loc9_.intCD = _loc6_.intCD;
            _loc9_.type = _loc6_.type;
            _loc9_.currentVehicleName = _loc5_.userName;
            _loc9_.inventoryID = _loc5_.inventoryID;
            _loc9_.iconContour = _loc5_.iconContour;
            _loc9_.icon = _loc5_.icon;
            _loc9_.currentVehicleBroken = _loc6_.isBroken;
            _loc9_.currentVehicleLocked = _loc6_.isLocked || _loc7_;
            _loc9_.currentVehicleLockMessage = param1.lockMessage;
         }
         this.specializationLevel = _loc3_.roleLevel;
         this.skillsCountForLearn = _loc3_.newSkillsCount[0];
         this.lastNewSkillExp = _loc3_.newSkillsCount[1];
         this.skills = this.parseCarouselTankmanSkills(_loc3_.skills,this.skillsCountForLearn,this.inventoryID,false);
         this.freeSkills = this.parseCarouselTankmanSkills(_loc3_.freeSkills,_loc3_.newFreeSkillsCount,this.inventoryID,true);
         this.roleType = _loc3_.roleName;
         this.role = _loc3_.roleUserName;
         this.modifiers = param1.modifiers;
         this.enoughFreeXPForTeaching = param1.enoughFreeXPForTeaching;
      }
      
      private function parseCarouselTankmanSkills(param1:Array, param2:int, param3:int, param4:Boolean) : Array
      {
         var _loc7_:CarouselTankmanSkillsModel = null;
         var _loc8_:Object = null;
         var _loc10_:CarouselTankmanSkillsModel = null;
         var _loc5_:Array = [];
         var _loc6_:int = param1.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc6_)
         {
            _loc7_ = new CarouselTankmanSkillsModel();
            _loc8_ = param1[_loc9_];
            _loc7_.description = _loc8_.description;
            _loc7_.icon = _loc8_.icon.big;
            _loc7_.roleIcon = _loc8_.icon.role;
            _loc7_.isActive = _loc8_.isActive;
            _loc7_.isCommon = _loc8_.roleType == CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
            _loc7_.isPerk = _loc8_.isPerk;
            _loc7_.level = _loc8_.level;
            _loc7_.userName = _loc8_.userName;
            _loc7_.name = _loc8_.name;
            _loc7_.tankmanID = param3;
            _loc7_.enabled = _loc8_.isEnable;
            _loc7_.isPermanent = _loc8_.isPermanent;
            _loc7_.isFreeSkill = param4;
            _loc5_.push(_loc7_);
            _loc9_++;
         }
         if(param2 > 0)
         {
            _loc10_ = new CarouselTankmanSkillsModel();
            _loc10_.isNewSkill = true;
            _loc10_.isBootcamp = this.isBootcamp;
            _loc10_.skillsCountForLearn = param2;
            _loc10_.tankmanID = param3;
            _loc10_.isFreeSkill = param4;
            _loc5_.push(_loc10_);
         }
         return _loc5_;
      }
      
      public final function dispose() : void
      {
         var _loc1_:PersonalCaseTabNameVO = null;
         this._disposed = true;
         this.actionChangeRole.dispose();
         this.actionChangeRole = null;
         this.nativeVehicle = null;
         this.currentVehicle = null;
         this.skills.splice(0);
         this.skills = null;
         this.modifiers.splice(0);
         this.modifiers = null;
         for each(_loc1_ in this.tabsData)
         {
            _loc1_.dispose();
         }
         this.tabsData.splice(0);
         this.tabsData = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}

class NativeVehicle
{
    
   
   public var userName:String = null;
   
   public var contourIconFile:String = null;
   
   public var icon:String = null;
   
   public var intCD:int;
   
   public var type:String = null;
   
   function NativeVehicle()
   {
      super();
   }
}
