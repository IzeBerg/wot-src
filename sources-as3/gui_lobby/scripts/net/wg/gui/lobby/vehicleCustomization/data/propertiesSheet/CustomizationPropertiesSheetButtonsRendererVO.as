package net.wg.gui.lobby.vehicleCustomization.data.propertiesSheet
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationPropertiesSheetButtonsRendererVO extends CustomizationPropertiesSheetRendererVO
   {
      
      private static const BTNS_BLOCK_VO:String = "btnsBlockVO";
      
      private static const ITEM_RENDERER_VO:String = "itemRendererVOs";
       
      
      public var multiselectionEnable:Boolean = false;
      
      public var titleText:String = "";
      
      public var itemRendererVOs:DataProvider = null;
      
      public var btnsBlockVO:Vector.<CustomizationPropertiesSheetButtonsBlockVO> = null;
      
      public function CustomizationPropertiesSheetButtonsRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(param1 == BTNS_BLOCK_VO)
         {
            this.btnsBlockVO = new Vector.<CustomizationPropertiesSheetButtonsBlockVO>();
            for each(_loc3_ in param2)
            {
               this.btnsBlockVO.push(new CustomizationPropertiesSheetButtonsBlockVO(_loc3_));
            }
            return false;
         }
         if(param1 == ITEM_RENDERER_VO && param2 != null)
         {
            this.itemRendererVOs = new DataProvider();
            for each(_loc4_ in param2)
            {
               this.itemRendererVOs.push(new CustomizationPropertiesSheetStyleRendererVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc2_:CustomizationPropertiesSheetStyleRendererVO = null;
         var _loc1_:IDisposable = null;
         if(this.btnsBlockVO != null)
         {
            for each(_loc1_ in this.btnsBlockVO)
            {
               _loc1_.dispose();
            }
            this.btnsBlockVO.splice(0,this.btnsBlockVO.length);
            this.btnsBlockVO = null;
         }
         if(this.itemRendererVOs != null)
         {
            for each(_loc2_ in this.itemRendererVOs)
            {
               _loc2_.dispose();
            }
            this.itemRendererVOs.splice(0,this.itemRendererVOs.length);
            this.itemRendererVOs = null;
         }
         super.onDispose();
      }
   }
}
