package net.wg.gui.lobby.battlequeue
{
   import fl.motion.easing.Cubic;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.gui.components.interfaces.IListItemAnimatedRenderer;
   import net.wg.gui.events.AnimatedRendererEvent;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.motion.Tween;
   
   public class BattleStrongholdsLeagueRenderer extends UIComponentEx implements IListItemAnimatedRenderer, IUpdatable, IScrollerItemRenderer
   {
      
      private static const ELO_ICON_OFFSET:int = 33;
      
      private static const FADE_IN_DELAY:Number = 300;
      
      private static const FADE_IN_DURATION:Number = 500;
      
      private static const FADE_OUT_DELAY:Number = 100;
      
      private static const FADE_OUT_DURATION:Number = 300;
      
      private static const Y_OUT_POSITION:Number = 150;
      
      private static const Y_IN_POSITION:Number = -150;
      
      private static const CLAN_ICON_Y_CENTER:int = 92;
       
      
      public var leagueIcon:UILoaderAlt;
      
      public var clanIcon:UILoaderAlt;
      
      public var positionTF:TextField;
      
      public var clanTF:TextField;
      
      public var eloTF:TextField;
      
      public var eloRatingIcon:Sprite;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _rendererWidth:Number = 0;
      
      private var _rendererHeight:Number = 0;
      
      private var _hasSize:Boolean = false;
      
      private var _data:BattleStrongholdsLeaguesLeaderVO;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent;
      
      private var _fadeInTween:Tween;
      
      private var _fadeOutTween:Tween;
      
      private var _tweens:Vector.<IDisposable>;
      
      private var _viewOpacity:Number = 1.0;
      
      public function BattleStrongholdsLeagueRenderer()
      {
         this._tweens = new Vector.<IDisposable>(0);
         super();
         this._toolTipMgr = App.toolTipMgr;
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         this._rendererWidth = param1;
         this._rendererHeight = param2;
         this._hasSize = true;
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.positionTF.autoSize = TextFieldAutoSize.CENTER;
         this.positionTF.mouseEnabled = false;
         this.eloTF.autoSize = TextFieldAutoSize.CENTER;
         this.leagueIcon.addEventListener(UILoaderEvent.COMPLETE,this.onLeagueIconCompleteHandler);
         this.clanIcon.mouseChildren = this.clanIcon.mouseEnabled = false;
         this.clanIcon.autoSize = false;
         this.clanIcon.addEventListener(UILoaderEvent.COMPLETE,this.onClanIconCompleteHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.viewOpacity = 0;
         this.leagueIcon.mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.positionTF.htmlText = this._data.title;
            this.clanTF.htmlText = this._data.clanName;
            this.eloTF.text = this._data.clanElo;
            this.leagueIcon.scaleX = this.leagueIcon.scaleY = 1;
            this.leagueIcon.source = this._data.leagueIcon;
            this.clanIcon.source = this._data.clanIcon;
            invalidateSize();
            this.y = Y_OUT_POSITION;
            this.playBeginAnimation();
         }
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            if(this._hasSize)
            {
               if(this.leagueIcon.width > this._rendererWidth || this.leagueIcon.height > this._rendererHeight)
               {
                  _loc1_ = this._rendererWidth / this.leagueIcon.width;
                  _loc2_ = this._rendererHeight / this.leagueIcon.height;
                  this.leagueIcon.scaleX = this.leagueIcon.scaleY = _loc1_ > _loc2_ ? Number(_loc2_) : Number(_loc1_);
               }
            }
            this.eloRatingIcon.x = this._rendererWidth - this.eloTF.width - this.eloRatingIcon.width >> 1;
            this.eloTF.x = this.eloRatingIcon.x + ELO_ICON_OFFSET;
         }
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = BattleStrongholdsLeaguesLeaderVO(param1);
         invalidateData();
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this.leagueIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onLeagueIconCompleteHandler);
         this.leagueIcon.dispose();
         this.leagueIcon = null;
         this.clanIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onClanIconCompleteHandler);
         this.clanIcon.dispose();
         this.clanIcon = null;
         this.eloRatingIcon = null;
         this.positionTF = null;
         this.clanTF = null;
         this.eloTF = null;
         this._owner = null;
         this._data = null;
         this._toolTipMgr = null;
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         for each(_loc1_ in this._tweens)
         {
            _loc1_.dispose();
         }
         this._tweens.splice(0,this._tweens.length);
         this._tweens = null;
         super.onDispose();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._data.tooltip))
         {
            this._toolTipMgr.showComplex(this._data.tooltip);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onLeagueIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.leagueIcon.x = this._rendererWidth - this.leagueIcon.width >> 1;
         invalidateSize();
      }
      
      private function onClanIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.clanIcon.x = this._rendererWidth - this.clanIcon.width >> 1;
         this.clanIcon.y = CLAN_ICON_Y_CENTER - (this.clanIcon.height >> 1);
      }
      
      override public function get width() : Number
      {
         return this._rendererWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         this.setSize(param1,this._rendererHeight);
      }
      
      override public function get height() : Number
      {
         return this._rendererHeight;
      }
      
      override public function set height(param1:Number) : void
      {
         this.setSize(this._rendererWidth,param1);
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this.setData(param1);
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._toolTipMgr = param1;
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
      }
      
      public function get viewOpacity() : Number
      {
         return this._viewOpacity;
      }
      
      public function set viewOpacity(param1:Number) : void
      {
         this._viewOpacity = param1;
         this.alpha = this._viewOpacity;
      }
      
      public function playEndAnimation() : void
      {
         this.stopTweens();
         var _loc1_:Number = (this.index + 1) * FADE_OUT_DELAY;
         this._fadeOutTween = new Tween(FADE_OUT_DURATION,this,{
            "viewOpacity":0,
            "y":Y_IN_POSITION
         },{
            "paused":false,
            "ease":Cubic.easeOut,
            "onComplete":this.animationFinished,
            "delay":_loc1_
         });
         this._tweens.push(this._fadeOutTween);
      }
      
      private function playBeginAnimation() : void
      {
         var _loc1_:Number = NaN;
         this.stopTweens();
         if(this.viewOpacity < 1)
         {
            _loc1_ = (this.index + 1) * FADE_IN_DELAY;
            this._fadeInTween = new Tween(FADE_IN_DURATION,this,{
               "viewOpacity":1,
               "y":0
            },{
               "paused":false,
               "ease":Cubic.easeOut,
               "delay":_loc1_
            });
            this._tweens.push(this._fadeInTween);
         }
      }
      
      private function stopTweens() : void
      {
         if(this._fadeOutTween)
         {
            this._fadeOutTween.paused = true;
         }
         if(this._fadeInTween)
         {
            this._fadeInTween.paused = true;
         }
      }
      
      private function animationFinished() : void
      {
         dispatchEvent(new AnimatedRendererEvent(AnimatedRendererEvent.RENERER_ANIMATION_FINISHED,this.index,true));
      }
      
      public function get rowsCount() : int
      {
         return Values.ZERO;
      }
      
      public function set rowsCount(param1:int) : void
      {
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
   }
}
