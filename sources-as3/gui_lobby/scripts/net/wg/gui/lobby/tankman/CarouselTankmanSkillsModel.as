package net.wg.gui.lobby.tankman
{
   public class CarouselTankmanSkillsModel
   {
      
      public static const ROLE_TYPE_COMMON:String = "common";
       
      
      public var name:String = "";
      
      public var description:String = null;
      
      public var icon:String = "";
      
      public var roleIcon:String = "";
      
      public var isActive:Boolean = false;
      
      public var isCommon:Boolean = false;
      
      public var isPerk:Boolean = false;
      
      public var userName:String = null;
      
      public var isNewSkill:Boolean = false;
      
      public var skillsCountForLearn:int = 0;
      
      public var enabled:Boolean = true;
      
      public var isPermanent:Boolean;
      
      public var tankmanID:int = -1;
      
      private var _level:int = -1;
      
      public function CarouselTankmanSkillsModel()
      {
         super();
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
   }
}
