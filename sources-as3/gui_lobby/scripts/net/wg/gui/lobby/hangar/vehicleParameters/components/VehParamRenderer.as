package net.wg.gui.lobby.hangar.vehicleParameters.components
{
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.advanced.StatusDeltaIndicatorAnim;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehParamRenderer extends SoundListItemRenderer
   {
      
      private static const TITLE_BASE_WIDTH:int = 240;
      
      private static const TITLE_EXTRA_WIDTH:int = 264;
      
      private static const RENDERER_HEIGHT:int = 24;
      
      private static const SIMPLE_TITLE_TF_X:int = 117;
      
      private static const SIMPLE_VALUE_TF_X:int = 265;
      
      private static const ADVANCED_TITLE_TF_X:int = 146;
      
      private static const EXTRA_TITLE_TF_X:int = 120;
      
      private static const EXTRA_TITLE_TEXT_HEIGHT:int = 4;
      
      private static const ROTATION_0:int = 0;
      
      private static const ROTATION_90:int = 90;
      
      private static const BUFF_ICON_PADDING:int = -17;
      
      private static const LINE_SEPARATOR_WIDTH:int = 260;
      
      private static const LINE_SEPARATOR_X:int = 116;
      
      private static const LINE_SEPARATOR_Y:int = 11;
      
      private static const HIT_ZONE_GAP:int = 12;
      
      private static const MAX_HIT_VALUE_OVERLAY:int = 80;
       
      
      public var valueTF:TextField = null;
      
      public var titleTF:TextField = null;
      
      public var hitMC:Sprite = null;
      
      public var icon:Image = null;
      
      public var indicator:StatusDeltaIndicatorAnim = null;
      
      public var arrow:Sprite = null;
      
      public var buffIcon:Image = null;
      
      public var separator:Sprite = null;
      
      private var _model:VehParamVO = null;
      
      private var _tooltip:String = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _simpleHitX:int = 0;
      
      private var _simpleHitW:int = 0;
      
      public function VehParamRenderer()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override public function canPlaySound(param1:String) : Boolean
      {
         return false;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this._tooltipMgr.hide();
         this._model = VehParamVO(param1);
         this.titleTF.multiline = false;
         this.titleTF.wordWrap = false;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.valueTF.mouseEnabled = false;
         this.titleTF.mouseEnabled = false;
         this.titleTF.blendMode = BlendMode.SCREEN;
         this.hitMC.height = height;
         hitArea = this.hitMC;
         this._simpleHitX = this.arrow.x - (this.arrow.width >> 1) - HIT_ZONE_GAP;
         this._simpleHitW = width - this._simpleHitX;
         mouseEnabledOnDisabled = true;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this._tooltipMgr.hide();
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.valueTF = null;
         this.titleTF = null;
         this._model = null;
         this.hitMC = null;
         this.icon.dispose();
         this.icon = null;
         this.indicator.dispose();
         this.indicator = null;
         this.buffIcon.dispose();
         this.buffIcon = null;
         this.arrow = null;
         this._tooltipMgr = null;
         this.separator = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         this.titleTF.height = RENDERER_HEIGHT;
         this.titleTF.width = TITLE_BASE_WIDTH;
         this.hitMC.height = RENDERER_HEIGHT;
         height = RENDERER_HEIGHT;
         super.draw();
         this.hideAll();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            this._tooltip = this._model.tooltip;
            enabled = buttonMode = this._model.isEnabled;
            if(StringUtils.isNotEmpty(this._model.valueText))
            {
               this.valueTF.htmlText = this._model.valueText;
            }
            if(StringUtils.isNotEmpty(this._model.valueText))
            {
               this.titleTF.htmlText = this._model.titleText;
            }
            if(this._model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_TOP)
            {
               this.titleTF.x = SIMPLE_TITLE_TF_X;
               this.valueTF.x = SIMPLE_VALUE_TF_X;
               this.arrow.rotation = !!this._model.isOpen ? Number(ROTATION_90) : Number(ROTATION_0);
               this.buffIcon.visible = StringUtils.isNotEmpty(this._model.buffIconSrc);
               if(this.buffIcon.visible)
               {
                  this.buffIcon.source = this._model.buffIconSrc;
                  this.buffIcon.x = this.valueTF.x + this.valueTF.width - this.valueTF.textWidth + BUFF_ICON_PADDING;
               }
               this.titleTF.visible = true;
               this.valueTF.visible = true;
               this.arrow.visible = true;
            }
            else if(this._model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_SIMPLE_BOTTOM)
            {
               this.indicator.setData(this._model.indicatorVO);
               this.indicator.visible = true;
               this.buffIcon.visible = false;
            }
            else if(this._model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED)
            {
               this.titleTF.x = ADVANCED_TITLE_TF_X;
               this.valueTF.x = 0;
               this.icon.visible = StringUtils.isNotEmpty(this._model.iconSource);
               if(this.icon.visible)
               {
                  this.icon.source = this._model.iconSource;
               }
               mouseChildren = true;
               this.titleTF.visible = true;
               this.valueTF.visible = true;
               this.buffIcon.visible = false;
            }
            else if(this._model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_EXTRA)
            {
               this.titleTF.multiline = true;
               this.titleTF.wordWrap = true;
               this.icon.visible = StringUtils.isNotEmpty(this._model.iconSource);
               if(this.icon.visible)
               {
                  this.icon.source = this._model.iconSource;
                  this.titleTF.width = TITLE_BASE_WIDTH;
                  this.titleTF.x = ADVANCED_TITLE_TF_X;
               }
               else
               {
                  this.titleTF.width = TITLE_EXTRA_WIDTH;
                  this.titleTF.x = EXTRA_TITLE_TF_X;
               }
               this.titleTF.height = Math.max(RENDERER_HEIGHT,this.titleTF.textHeight + EXTRA_TITLE_TEXT_HEIGHT);
               this.valueTF.x = 0;
               height = this.titleTF.height;
               this.hitMC.height = height;
               mouseChildren = true;
               this.titleTF.visible = true;
               this.valueTF.visible = true;
            }
            else if(this._model.state == HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_LINE_SEPARATOR && this.separator)
            {
               this.separator.visible = true;
               this.separator.x = LINE_SEPARATOR_X;
               this.separator.y = LINE_SEPARATOR_Y;
               this.separator.width = LINE_SEPARATOR_WIDTH;
            }
            if(this._model.state != HANGAR_ALIASES.VEH_PARAM_RENDERER_STATE_ADVANCED)
            {
               this.hitMC.x = this._simpleHitX;
               this.hitMC.width = this._simpleHitW;
            }
            else
            {
               this.layoutHitArea();
            }
         }
      }
      
      private function hideAll() : void
      {
         this.titleTF.visible = false;
         this.valueTF.visible = false;
         this.indicator.visible = false;
         this.arrow.visible = false;
         this.icon.visible = false;
         this.buffIcon.visible = false;
         if(this.separator)
         {
            this.separator.visible = false;
         }
      }
      
      private function layoutHitArea() : void
      {
         this.hitMC.x = this.valueTF.width - Math.min(this.valueTF.textWidth + HIT_ZONE_GAP,MAX_HIT_VALUE_OVERLAY);
         this.hitMC.width = width - this.hitMC.x;
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltip))
         {
            this._tooltipMgr.showSpecial(this._tooltip,null,this._model.paramID);
         }
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
