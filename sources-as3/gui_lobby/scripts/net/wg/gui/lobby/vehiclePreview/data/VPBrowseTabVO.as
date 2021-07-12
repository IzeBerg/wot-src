package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.gui.data.BenefitsDataVO;
   
   public class VPBrowseTabVO extends BenefitsDataVO
   {
       
      
      public var historicReferenceTxt:String = "";
      
      public var showTooltip:Boolean = false;
      
      public var vehicleType:int = -1;
      
      public var titleInfo:String = "";
      
      public function VPBrowseTabVO(param1:Object)
      {
         super(param1);
      }
   }
}
