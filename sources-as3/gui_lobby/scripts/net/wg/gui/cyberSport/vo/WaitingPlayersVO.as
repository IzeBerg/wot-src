package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class WaitingPlayersVO extends DAAPIDataClass
   {
       
      
      public var showAlert:Boolean = false;
      
      public var alertTooltip:String = "";
      
      public var alertIcon:String = "";
      
      public function WaitingPlayersVO(param1:Object)
      {
         super(param1);
      }
   }
}
