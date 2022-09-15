package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionsFilterPopoverInitVO extends DAAPIDataClass
   {
       
      
      public var titleLabel:String = "";
      
      public var defaultButtonLabel:String = "";
      
      public var defaultButtonTooltip:String = "";
      
      public var hideDoneLabel:String = "";
      
      public var hideUnavailableLabel:String = "";
      
      public function MissionsFilterPopoverInitVO(param1:Object)
      {
         super(param1);
      }
   }
}
