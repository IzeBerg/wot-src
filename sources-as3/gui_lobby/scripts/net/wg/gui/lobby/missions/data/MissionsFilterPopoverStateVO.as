package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionsFilterPopoverStateVO extends DAAPIDataClass
   {
       
      
      public var hideDone:Boolean = false;
      
      public var hideUnavailable:Boolean = false;
      
      public function MissionsFilterPopoverStateVO(param1:Object)
      {
         super(param1);
      }
   }
}
