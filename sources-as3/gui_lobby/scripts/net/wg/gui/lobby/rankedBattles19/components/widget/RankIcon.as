package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IRankIcon;
   import net.wg.gui.lobby.rankedBattles19.data.RankIconVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankShieldVO;
   import net.wg.gui.lobby.rankedBattles19.events.RankWidgetEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankIcon extends UIComponentEx implements IRankIcon
   {
      
      private static const DISABLED_LABEL:String = "disabled";
      
      private static const IMAGE_SIZES:Object = {};
      
      private static const REFLECTION_SIZES:Object = {};
      
      private static const REFLECTION_POSITIONS:Object = {};
      
      {
         IMAGE_SIZES[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = new Point(58,80);
         IMAGE_SIZES[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = new Point(80,110);
         IMAGE_SIZES[RANKEDBATTLES_ALIASES.WIDGET_BIG] = new Point(114,160);
         IMAGE_SIZES[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = new Point(190,260);
         REFLECTION_SIZES[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = new Point(52,75);
         REFLECTION_SIZES[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = new Point(74,102);
         REFLECTION_SIZES[RANKEDBATTLES_ALIASES.WIDGET_BIG] = new Point(74,102);
         REFLECTION_SIZES[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = new Point(74,102);
         REFLECTION_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = new Point(5,3);
         REFLECTION_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = new Point(5,5);
         REFLECTION_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_BIG] = new Point(5,5);
         REFLECTION_POSITIONS[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = new Point(5,5);
      }
      
      public var reflection:MovieClip = null;
      
      public var hit:Sprite = null;
      
      public var rankImg:IImage = null;
      
      public var shield:RankShieldContainer = null;
      
      private var _model:RankIconVO = null;
      
      private var _reflectionLooped:Boolean = true;
      
      private var _isEnabled:Boolean = true;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _rankSize:String = "";
      
      private var _isReflectionEnabled:Boolean = true;
      
      public function RankIcon()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         hitArea = this.hit;
         this.reflection.mouseEnabled = this.reflection.mouseChildren = false;
         this.reflection.gotoAndStop(1);
         this.reflection.addFrameScript(this.reflection.totalFrames - 1,this.reflectionFinished);
      }
      
      override protected function configUI() : void
      {
         Sprite(this.rankImg).mouseEnabled = true;
         this.shield.mouseEnabled = this.shield.mouseChildren = false;
         this.rankImg.addEventListener(MouseEvent.ROLL_OVER,this.onHitRollOverHandler);
         this.rankImg.addEventListener(MouseEvent.ROLL_OUT,this.onHitRollOutHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.reflection.addFrameScript(this.reflection.totalFrames - 1,null);
         this.reflection.stop();
         this.rankImg.removeEventListener(MouseEvent.ROLL_OVER,this.onHitRollOverHandler);
         this.rankImg.removeEventListener(MouseEvent.ROLL_OUT,this.onHitRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.shield.dispose();
         this.shield = null;
         this.rankImg.dispose();
         this.rankImg = null;
         hitArea = null;
         this.reflection = null;
         this.hit = null;
         this._tooltipMgr = null;
         this._model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._model != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._model.imageSrc;
            if(this._rankSize == RANKEDBATTLES_ALIASES.WIDGET_SMALL)
            {
               _loc1_ = this._model.smallImageSrc;
            }
            if(StringUtils.isNotEmpty(_loc1_))
            {
               this.rankImg.source = _loc1_;
               this.isEnabled = this._model.isEnabled;
               this.shield.setData(this._model.shield);
            }
            this.calcSize();
         }
      }
      
      public function enableReflection(param1:Boolean) : void
      {
         if(this._isReflectionEnabled == param1)
         {
            return;
         }
         this._isReflectionEnabled = param1;
         if(!this._isReflectionEnabled)
         {
            this.reflection.gotoAndStop(1);
         }
      }
      
      public function getShieldOffset(param1:String) : Number
      {
         return this.shield.getShieldOffset(param1);
      }
      
      public function hasVisibleShield() : Boolean
      {
         var _loc2_:RankShieldVO = null;
         var _loc1_:Boolean = false;
         if(this._model)
         {
            _loc2_ = this._model.shield;
            return _loc2_ && RANKEDBATTLES_ALIASES.SHIELD_NOT_VISIBLE_STATES.indexOf(_loc2_.state) == Values.DEFAULT_INT;
         }
         return _loc1_;
      }
      
      public function showReflection(param1:Boolean, param2:Boolean = false) : void
      {
         this._reflectionLooped = param2;
         if(param1 && this._isReflectionEnabled)
         {
            this.reflection.gotoAndPlay(1);
            this.dispatchBlink();
         }
         else
         {
            this.reflection.gotoAndStop(1);
         }
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null)
         {
            this._model = RankIconVO(param1);
            invalidateData();
         }
         else
         {
            gotoAndStop(1);
            visible = false;
         }
      }
      
      public function useButtonMode(param1:Boolean) : void
      {
         useHandCursor = buttonMode = param1;
         Sprite(this.rankImg).useHandCursor = Sprite(this.rankImg).buttonMode = param1;
      }
      
      private function calcSize() : void
      {
         this.reflection.gotoAndStop(1);
         this.hit.width = IMAGE_SIZES[this._rankSize].x;
         this.hit.height = IMAGE_SIZES[this._rankSize].y;
         this.reflection.width = REFLECTION_SIZES[this._rankSize].x;
         this.reflection.height = REFLECTION_SIZES[this._rankSize].y;
         this.reflection.x = REFLECTION_POSITIONS[this._rankSize].x;
         this.reflection.y = REFLECTION_POSITIONS[this._rankSize].y;
         this.shield.updateSize(this._rankSize);
      }
      
      private function reflectionFinished() : void
      {
         if(!this._reflectionLooped)
         {
            this.reflection.gotoAndStop(1);
         }
         else
         {
            this.dispatchBlink();
         }
      }
      
      private function dispatchBlink() : void
      {
         dispatchEvent(new RankWidgetEvent(RankWidgetEvent.BLINK_STARTED));
      }
      
      override public function get width() : Number
      {
         return this.hit.width;
      }
      
      override public function get height() : Number
      {
         return this.hit.height;
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
         gotoAndStop(!!this._isEnabled ? 1 : DISABLED_LABEL);
      }
      
      public function get componentSize() : String
      {
         return this._rankSize;
      }
      
      public function set componentSize(param1:String) : void
      {
         if(this._rankSize == param1)
         {
            return;
         }
         this._rankSize = param1;
         invalidateData();
      }
      
      private function onHitRollOverHandler(param1:MouseEvent) : void
      {
         if(this._model != null && this._model.hasTooltip)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_RANK,null,this._model.rankID);
         }
      }
      
      private function onHitRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
