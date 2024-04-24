package net.wg.gui.lobby.storage.categories.blueprints
{
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.IconTextPosition;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.ImageTextComponent;
   import net.wg.gui.lobby.storage.data.BlueprintsFragmentVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class BlueprintFragmentRenderer extends UIComponentEx implements IUpdatable, IStageSizeDependComponent
   {
      
      private static const COUNT_TEXT_GAP:int = -1;
      
      private static const RENDERER_WIDTH_SMALL:int = 40;
      
      private static const RENDERER_HEIGHT_SMALL:int = 50;
      
      private static const RENDERER_WIDTH_BIG:int = 64;
      
      private static const RENDERER_HEIGHT_BIG:int = 100;
      
      private static const ICON_SIZE_SMALL:String = "small";
      
      private static const ICON_SIZE_BIG:String = "big";
      
      private static const COLOR_TRANSFORM_NO_FRAGMENTS:ColorTransform = new ColorTransform(0.35,0.35,0.35);
       
      
      public var imageText:ImageTextComponent = null;
      
      private var _data:BlueprintsFragmentVO = null;
      
      private var _iconSize:String = null;
      
      public function BlueprintFragmentRenderer()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.imageText.setSize(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.stageSizeMgr.register(this);
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
         this._data = null;
         this.imageText.dispose();
         this.imageText = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.imageText.horizontalCenter = 0;
         this.imageText.iconPosition = IconTextPosition.TOP;
         this.imageText.gap = COUNT_TEXT_GAP;
         this.imageText.textAutoSize = TextFieldAutoSize.CENTER;
         this.imageText.textAlign = TextFormatAlign.CENTER;
         this.imageText.updateTextFieldSize = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.imageText.htmlText = this._data.label;
               this.imageText.icon.transform.colorTransform = !!this._data.hasFragments ? null : COLOR_TRANSFORM_NO_FRAGMENTS;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.imageText.iconSource = this._iconSize == ICON_SIZE_SMALL ? this._data.iconSmall : this._data.iconBig;
            }
         }
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:String = param1 < StageSizeBoundaries.WIDTH_1600 ? ICON_SIZE_SMALL : ICON_SIZE_BIG;
         if(this._iconSize == _loc3_)
         {
            return;
         }
         this._iconSize = _loc3_;
         if(this._iconSize == ICON_SIZE_SMALL)
         {
            this.setSize(RENDERER_WIDTH_SMALL,RENDERER_HEIGHT_SMALL);
         }
         else
         {
            this.setSize(RENDERER_WIDTH_BIG,RENDERER_HEIGHT_BIG);
         }
      }
      
      public function update(param1:Object) : void
      {
         if(this._data == param1)
         {
            return;
         }
         this._data = BlueprintsFragmentVO(param1);
         invalidateData();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.BLUEPRINT_FRAGMENT_INFO,null,this._data.tooltipData);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
