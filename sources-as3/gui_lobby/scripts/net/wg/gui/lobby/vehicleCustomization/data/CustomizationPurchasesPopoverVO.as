package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.vehicleCustomization.data.purchase.PurchasesPopoverRendererVO;
   
   public class CustomizationPurchasesPopoverVO extends DAAPIDataClass
   {
      
      private static const RENDERERS_FIELD:String = "popoverRenderers";
       
      
      public var title:String = "";
      
      private var _popoverRenderers:Vector.<PurchasesPopoverRendererVO> = null;
      
      public function CustomizationPurchasesPopoverVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:PurchasesPopoverRendererVO = null;
         if(param1 == RENDERERS_FIELD)
         {
            this._popoverRenderers = new Vector.<PurchasesPopoverRendererVO>();
            _loc3_ = {};
            _loc4_ = null;
            for each(_loc3_ in param2)
            {
               _loc4_ = new PurchasesPopoverRendererVO(_loc3_);
               this._popoverRenderers.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = this._popoverRenderers.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this._popoverRenderers[_loc1_].dispose();
            _loc1_++;
         }
         this._popoverRenderers.splice(0,_loc2_);
         this._popoverRenderers = null;
         super.onDispose();
      }
      
      public function get popoverRenderers() : Vector.<PurchasesPopoverRendererVO>
      {
         return this._popoverRenderers;
      }
   }
}
