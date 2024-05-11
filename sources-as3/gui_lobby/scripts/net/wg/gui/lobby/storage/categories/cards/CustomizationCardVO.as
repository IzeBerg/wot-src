package net.wg.gui.lobby.storage.categories.cards
{
   public class CustomizationCardVO extends BaseCardVO
   {
       
      
      public var vehicleCD:Number;
      
      public var previewAvailable:Boolean = true;
      
      public var isRentable:Boolean = false;
      
      public var previewTooltip:String = "";
      
      public var progressiveLevelIcon:String = "";
      
      public var formfactor:String = "";
      
      public function CustomizationCardVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEqual(param1:BaseCardVO) : Boolean
      {
         var _loc2_:CustomizationCardVO = param1 as CustomizationCardVO;
         if(_loc2_ == null)
         {
            return false;
         }
         return super.isEqual(_loc2_) && this.previewAvailable == _loc2_.previewAvailable && this.isRentable == _loc2_.isRentable && this.previewTooltip == _loc2_.previewTooltip && this.progressiveLevelIcon == _loc2_.progressiveLevelIcon && this.formfactor == _loc2_.formfactor;
      }
      
      override public function toString() : String
      {
         return "[CustomizationCardVO > id: " + id + ", image: " + image + "]";
      }
   }
}
