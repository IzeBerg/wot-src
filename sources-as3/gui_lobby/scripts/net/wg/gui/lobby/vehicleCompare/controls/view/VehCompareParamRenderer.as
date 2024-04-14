package net.wg.gui.lobby.vehicleCompare.controls.view
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareParamsListEvent;
   import net.wg.gui.lobby.vehicleCompare.events.VehCompareVehParamRendererEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehCompareParamRenderer extends SoundListItemRenderer
   {
      
      private static const SIMPLE_TITLE_TF_X:int = 39;
      
      private static const ADVANCED_TITLE_TF_X:int = 68;
      
      private static const ROTATION_0:int = 0;
      
      private static const ROTATION_90:int = 90;
      
      private static const DOTS:String = "...";
      
      private static const TITLE_ELLIPSIS_RIGHT_PADDING:int = 8;
      
      private static const ELLIPSIS_CUT_CHARS:int = 2;
       
      
      public var titleTF:TextField = null;
      
      public var hitMC:Sprite = null;
      
      public var icon:Image = null;
      
      public var arrow:Sprite = null;
      
      public var bottomLine:Sprite = null;
      
      private var _model:VehParamVO = null;
      
      private var _commons:ICommons = null;
      
      private var _tooltip:String = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function VehCompareParamRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         cacheAsBitmap = true;
         this._commons = App.utils.commons;
      }
      
      private static function isParentElement(param1:String) : Boolean
      {
         return param1 == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP;
      }
      
      private static function isChildElement(param1:String) : Boolean
      {
         return param1 == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED;
      }
      
      override public function setData(param1:Object) : void
      {
         this._tooltipMgr.hide();
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this._model = VehParamVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         this.bottomLine.visible = false;
         this.titleTF.mouseEnabled = false;
         hitArea = this.hitMC;
         mouseEnabledOnDisabled = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr.hide();
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.icon.dispose();
         this.icon = null;
         this.arrow = null;
         this._tooltipMgr = null;
         this.titleTF = null;
         this._model = null;
         this.hitMC = null;
         this._commons = null;
         this.bottomLine = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.hitMC.width = width;
            this.hitMC.height = height;
         }
         this.hideAll();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this._tooltip = this._model.tooltip;
            enabled = buttonMode = this._model.isEnabled;
            this.titleTF.htmlText = this._model.titleText;
            if(isParentElement(this._model.state))
            {
               this.titleTF.x = SIMPLE_TITLE_TF_X;
               this.arrow.rotation = !!this._model.isOpen ? Number(ROTATION_90) : Number(ROTATION_0);
               this.titleTF.visible = true;
               this.arrow.visible = true;
               this.bottomLine.visible = true;
               this.bottomLine.y = height;
            }
            else if(isChildElement(this._model.state))
            {
               this.titleTF.x = ADVANCED_TITLE_TF_X;
               this.icon.visible = StringUtils.isNotEmpty(this._model.iconSource);
               if(this.icon.visible)
               {
                  this.icon.source = this._model.iconSource;
               }
               this.bottomLine.visible = false;
               this._commons.updateTextFieldSize(this.titleTF,true,false);
               _loc1_ = this.hitMC.width - this.titleTF.x;
               if(this.titleTF.width > _loc1_)
               {
                  this.titleTF.width = _loc1_;
                  this.setTruncatedHtmlText();
               }
               this.titleTF.visible = true;
            }
         }
      }
      
      private function setTruncatedHtmlText() : void
      {
         var _loc4_:Rectangle = null;
         this.titleTF.visible = false;
         var _loc1_:String = this.titleTF.htmlText;
         var _loc2_:int = this.hitMC.width - this.titleTF.x - TITLE_ELLIPSIS_RIGHT_PADDING;
         var _loc3_:Rectangle = this.titleTF.getCharBoundaries(0);
         do
         {
            _loc1_ = _loc1_.substr(0,_loc1_.length - ELLIPSIS_CUT_CHARS);
            this.titleTF.htmlText = _loc1_ + DOTS;
            _loc4_ = this.titleTF.getCharBoundaries(this.titleTF.length - 1);
         }
         while(_loc4_.x - _loc3_.x > _loc2_);
         
      }
      
      private function hideAll() : void
      {
         this.titleTF.visible = false;
         this.arrow.visible = false;
         this.icon.visible = false;
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip))
         {
            this._tooltipMgr.showWulfTooltip(this._tooltip,this._model.paramID);
         }
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:VehCompareVehParamRendererEvent = null;
         if(this._model == null)
         {
            return;
         }
         if(isParentElement(this._model.state))
         {
            this._model.isOpen = !this._model.isOpen;
            dispatchEvent(new VehCompareParamsListEvent(VehCompareParamsListEvent.RENDER_CLICK,true));
         }
         else if(isChildElement(this._model.state))
         {
            _loc2_ = new VehCompareVehParamRendererEvent(VehCompareVehParamRendererEvent.PARAM_CLICK);
            _loc2_.stageY = param1.stageY;
            dispatchEvent(_loc2_);
         }
      }
   }
}
