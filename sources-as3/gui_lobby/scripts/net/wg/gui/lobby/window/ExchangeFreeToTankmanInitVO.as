package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.tankman.CarouselTankmanSkillsModel;
   
   public class ExchangeFreeToTankmanInitVO extends DAAPIDataClass
   {
       
      
      public var tankmanID:int = -1;
      
      private var _currentSkill:Object;
      
      public var lastSkillLevel:Number;
      
      public var nextSkillLevel:Number;
      
      private var _beforeSkill:CarouselTankmanSkillsModel;
      
      private var _afterSkill:ExchangeXPTankmanSkillsModel;
      
      public function ExchangeFreeToTankmanInitVO(param1:Object)
      {
         super(param1);
      }
      
      public function get currentSkill() : Object
      {
         return this._currentSkill;
      }
      
      public function set currentSkill(param1:Object) : void
      {
         this._currentSkill = param1;
         this._beforeSkill = new CarouselTankmanSkillsModel();
         this.initObject(this._beforeSkill,this._currentSkill);
         this._afterSkill = new ExchangeXPTankmanSkillsModel();
         this.initObject(this._afterSkill,this._currentSkill);
         this._afterSkill.defaultActiveValue = param1.isActive;
      }
      
      private function initObject(param1:CarouselTankmanSkillsModel, param2:Object) : void
      {
         param1.description = param2.description;
         param1.icon = param2.icon.big;
         param1.roleIcon = param2.icon.role;
         param1.isActive = param2.isActive;
         param1.isCommon = param2.roleType == CarouselTankmanSkillsModel.ROLE_TYPE_COMMON;
         param1.isPerk = param2.isPerk;
         param1.level = param2.level;
         param1.userName = param2.userName;
         param1.name = param2.name;
         param1.tankmanID = this.tankmanID;
      }
      
      public function get beforeSkill() : CarouselTankmanSkillsModel
      {
         return this._beforeSkill;
      }
      
      public function get afterSkill() : ExchangeXPTankmanSkillsModel
      {
         return this._afterSkill;
      }
   }
}
