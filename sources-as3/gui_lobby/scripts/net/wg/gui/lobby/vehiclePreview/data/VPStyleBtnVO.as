package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPStyleBtnVO extends DAAPIDataClass
   {
       
      
      public var isVisible:Boolean = false;
      
      public var isSelected:Boolean = false;
      
      public var styleIntCD:int = -1;
      
      public function VPStyleBtnVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
