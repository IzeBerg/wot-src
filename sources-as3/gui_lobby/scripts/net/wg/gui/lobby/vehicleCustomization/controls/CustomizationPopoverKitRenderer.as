package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationItemIconRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationPopoverKitRendererVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class CustomizationPopoverKitRenderer extends TableRenderer
   {
      
      private static const NAME_TF_MARGIN:uint = 14;
      
      private static const ITEM_ICON_HORIZONTAL_GAP:uint = 10;
      
      private static const ITEM_ICON_VERTICAL_GAP:uint = 10;
      
      private static const RENDERER_BG_HEIGHT_OFFSET:uint = 22;
      
      private static const START_X_OFFSET:uint = 3;
       
      
      public var nameTF:TextField = null;
      
      private var _model:CustomizationPopoverKitRendererVO = null;
      
      private var _itemIcons:Vector.<CustomizationItemIconRenderer> = null;
      
      public function CustomizationPopoverKitRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._model = CustomizationPopoverKitRendererVO(param1);
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._model && isInvalid(InvalidationType.DATA))
         {
            this.nameTF.htmlText = this._model.name;
            this.enabled = true;
            this.clearItemIcons();
            this.createItemIcons();
            this.layoutItemIconsAndResizeBg();
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearItemIcons();
         this.nameTF = null;
         this._model = null;
         this._itemIcons = null;
         super.onDispose();
      }
      
      private function createItemIcons() : void
      {
         var _loc3_:uint = 0;
         var _loc4_:CustomizationItemIconRenderer = null;
         var _loc5_:uint = 0;
         var _loc1_:Class = App.instance.utils.classFactory.getClass(Linkages.CUSTOMIZATION_ITEM_ICON_RENDERER);
         this._itemIcons = new Vector.<CustomizationItemIconRenderer>(0);
         var _loc2_:Vector.<CustomizationItemIconRendererVO> = this._model.itemIconsList;
         if(_loc2_)
         {
            _loc3_ = _loc2_.length;
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = new _loc1_();
               _loc4_.setData(_loc2_[_loc5_]);
               this._itemIcons[_loc5_] = _loc4_;
               _loc5_++;
            }
         }
      }
      
      private function layoutItemIconsAndResizeBg() : void
      {
         var _loc1_:uint = this._itemIcons.length;
         var _loc2_:CustomizationItemIconRenderer = null;
         var _loc3_:int = this.nameTF.x + START_X_OFFSET;
         var _loc4_:int = _loc3_;
         var _loc5_:int = this.nameTF.y + this.nameTF.textHeight + NAME_TF_MARGIN;
         var _loc6_:uint = rendererBg.width;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc1_)
         {
            _loc2_ = this._itemIcons[_loc7_];
            if(_loc4_ + _loc2_.width > _loc6_)
            {
               _loc4_ = _loc3_;
               _loc5_ += _loc2_.height + ITEM_ICON_VERTICAL_GAP;
            }
            _loc2_.x = _loc4_;
            _loc2_.y = _loc5_;
            _loc4_ += _loc2_.width + ITEM_ICON_HORIZONTAL_GAP;
            addChild(_loc2_);
            _loc7_++;
         }
         if(_loc2_)
         {
            rendererBg.height = _loc2_.y + _loc2_.height + RENDERER_BG_HEIGHT_OFFSET ^ 0;
         }
      }
      
      override public function get height() : Number
      {
         if(rendererBg)
         {
            return rendererBg.height;
         }
         return super.height;
      }
      
      private function clearItemIcons() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:CustomizationItemIconRenderer = null;
         var _loc3_:uint = 0;
         if(this._itemIcons)
         {
            _loc1_ = this._itemIcons.length;
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = this._itemIcons[_loc3_];
               removeChild(_loc2_);
               _loc2_.dispose();
               _loc3_++;
            }
            this._itemIcons.splice(0,this._itemIcons.length);
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
   }
}
