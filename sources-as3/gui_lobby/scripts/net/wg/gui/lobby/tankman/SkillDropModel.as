package net.wg.gui.lobby.tankman
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SkillDropModel implements IDisposable
   {
      
      public static const SAVING_MODE_GOLD:int = 2;
      
      public static const SAVING_MODE_CREDITS:int = 1;
       
      
      public var compactDescriptor:String = "";
      
      public var tankmanName:String = "";
      
      public var tankmanIcon:String = "";
      
      public var roleIcon:String = "";
      
      public var roleLevel:Number = NaN;
      
      public var nationID:Number = NaN;
      
      public var skillsCount:int = 0;
      
      public var lastSkill:String = null;
      
      public var lastSkillLevel:Number = NaN;
      
      public var preLastSkill:String = null;
      
      public var hasNewSkill:Boolean;
      
      public var newSkillsCount:int = 0;
      
      public var lastNewSkillLevel:Number = 0;
      
      public var dropSkillFree:DropSkillsCost;
      
      public var dropSkillCredits:DropSkillsCost;
      
      public var dropSkillGold:DropSkillsCost;
      
      public var defaultSavingMode:int;
      
      public var freeDropText:String = "";
      
      private var _disposed:Boolean = false;
      
      public function SkillDropModel(param1:Object)
      {
         var _loc3_:Object = null;
         super();
         this.compactDescriptor = param1.tankman.strCD;
         this.tankmanName = param1.tankman.fullName;
         this.tankmanIcon = param1.tankman.icon.big;
         this.roleIcon = param1.tankman.iconRole.small;
         this.roleLevel = param1.tankman.roleLevel;
         this.nationID = param1.tankman.nationID;
         var _loc2_:Array = param1.tankman.skills;
         this.skillsCount = _loc2_.length;
         if(this.skillsCount > 0)
         {
            _loc3_ = _loc2_[this.skillsCount - 1];
            this.lastSkill = _loc3_.icon.small;
            this.lastSkillLevel = _loc3_.level;
         }
         if(this.skillsCount > 1)
         {
            _loc3_ = _loc2_[this.skillsCount - 2];
            this.preLastSkill = _loc3_.icon.small;
         }
         this.hasNewSkill = param1.hasNewSkills;
         this.newSkillsCount = param1.newSkills[0];
         this.lastNewSkillLevel = param1.newSkills[1];
         this.dropSkillFree = new DropSkillsCost(param1.dropSkillsCost[0]);
         this.dropSkillFree.id = 0;
         this.dropSkillCredits = new DropSkillsCost(param1.dropSkillsCost[1]);
         this.dropSkillCredits.id = SAVING_MODE_CREDITS;
         this.dropSkillGold = new DropSkillsCost(param1.dropSkillsCost[2]);
         this.dropSkillGold.id = SAVING_MODE_GOLD;
         this.defaultSavingMode = param1.defaultSavingMode;
         if(param1.texts)
         {
            this.freeDropText = param1.texts.freeDrop;
         }
      }
      
      public function get nation() : String
      {
         return App.utils.nations.getNationName(this.nationID);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.dropSkillFree.dispose();
         this.dropSkillFree = null;
         this.dropSkillCredits.dispose();
         this.dropSkillCredits = null;
         this.dropSkillGold.dispose();
         this.dropSkillGold = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
