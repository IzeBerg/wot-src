package net.wg.gui.lobby.tankman
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.Extensions;
   
   public class PersonalCaseDocsModel implements IDisposable
   {
       
      
      public var firstNames:Array;
      
      public var lastNames:Array;
      
      public var icons:Array;
      
      public var currentTankmanFirstName:String = null;
      
      public var currentTankmanLastName:String = null;
      
      public var currentTankmanIcon:String = null;
      
      public var originalIconFile:String = null;
      
      public var warning:String = null;
      
      public var changeDocumentsEnable:Boolean = false;
      
      public var fistNameMaxChars:uint = 0;
      
      public var lastNameMaxChars:uint = 0;
      
      public function PersonalCaseDocsModel(param1:Object)
      {
         this.firstNames = [];
         this.lastNames = [];
         this.icons = [];
         super();
         this.firstNames = param1.firstnames;
         this.lastNames = param1.lastnames;
         this.calculateMaxChars(this.firstNames,this,"firstNames");
         this.calculateMaxChars(this.lastNames,this,"lastNames");
         this.icons = param1.icons;
         this.changeDocumentsEnable = param1.enableSubmitButton;
         if(!Extensions.isScaleform)
         {
            this.currentTankmanFirstName = param1.firstnames[0].value;
            this.currentTankmanLastName = param1.lastnames[0].value;
         }
         else
         {
            this.currentTankmanFirstName = param1.firstName;
            this.currentTankmanLastName = param1.lastName;
         }
      }
      
      public function dispose() : void
      {
         this.firstNames.splice(0);
         this.firstNames = null;
         this.lastNames.splice(0);
         this.lastNames = null;
         this.icons.splice(0);
         this.icons = null;
      }
      
      private function calculateMaxChars(param1:Array, param2:PersonalCaseDocsModel, param3:String) : void
      {
         var _loc6_:uint = 0;
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1[_loc5_]["value"].length;
            if(param3 == "firstNames" && _loc6_ > param2.fistNameMaxChars)
            {
               param2.fistNameMaxChars = _loc6_;
            }
            else if(param3 == "lastNames" && _loc6_ > param2.lastNameMaxChars)
            {
               param2.lastNameMaxChars = _loc6_;
            }
            _loc5_++;
         }
      }
   }
}
