package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class OperationVO extends DAAPIDataClass
   {
      
      private static const SHOW_DELAY:String = "showDelay";
       
      
      public var title:String = "";
      
      public var desc:String = "";
      
      public var iconSource:String = "";
      
      public var iconStateSource:String = "";
      
      public var freeSheetIconSource:String = "";
      
      public var freeSheetCounter:String = "";
      
      public var state:String = "";
      
      public var isSelected:Boolean = false;
      
      public var id:int = -1;
      
      public var showDelay:int = -1;
      
      public var tooltipAlias:String = "";
      
      public function OperationVO(param1:Object, param2:int = 0)
      {
         super(param1);
         if(!param1.hasOwnProperty(SHOW_DELAY))
         {
            this.showDelay = param2;
         }
      }
      
      public function isLocked() : Boolean
      {
         return this.state == PERSONAL_MISSIONS_ALIASES.OPERATION_LOCKED_STATE;
      }
   }
}
