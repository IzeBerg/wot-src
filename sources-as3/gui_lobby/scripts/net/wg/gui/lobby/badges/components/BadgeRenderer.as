package net.wg.gui.lobby.badges.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.assets.NewIndicator;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.lobby.badges.data.BadgeVO;
   import net.wg.gui.lobby.badges.events.BadgesEvent;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class BadgeRenderer extends SoundListItemRenderer
   {
      
      private static const INV_SELECTED:String = "inv_selected";
      
      private static const NOT_ENABLED_ALPHA:Number = 0.7;
      
      private static const ICON_AND_CONTENT_NOT_ENABLED_ALPHA:Number = 0.5;
      
      private static const STATE_NORMAL:String = "normal";
      
      private static const STATE_SELECTED:String = "selected";
      
      private static const STATE_DISABLED:String = "disabled";
       
      
      public var titleTF:TextField = null;
      
      public var descrTF:TextField = null;
      
      public var selectedImg:IImage = null;
      
      public var hit:Sprite = null;
      
      public var highlightIcon:IImage = null;
      
      public var newIndicator:NewIndicator = null;
      
      public var badgeComponent:BadgeComponent = null;
      
      private var _badgeData:BadgeVO = null;
      
      private var _seenByUser:Boolean = false;
      
      public function BadgeRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._badgeData = BadgeVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this.newIndicator.mouseChildren = false;
         this.newIndicator.mouseEnabled = false;
         addEventListener(ButtonEvent.CLICK,this.onClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this._badgeData != null && isInvalid(InvalidationType.DATA))
         {
            enabled = this._badgeData.enabled;
            alpha = !!enabled ? Number(1) : Number(NOT_ENABLED_ALPHA);
            this.titleTF.htmlText = this._badgeData.title;
            this.descrTF.htmlText = this._badgeData.description;
            this.badgeComponent.alpha = !!enabled ? Number(Values.DEFAULT_ALPHA) : Number(ICON_AND_CONTENT_NOT_ENABLED_ALPHA);
            this.highlightIcon.source = this._badgeData.highlightIcon;
            if(!this._seenByUser)
            {
               _loc1_ = this._badgeData.isFirstLook;
               this.newIndicator.visible = _loc1_;
               if(_loc1_)
               {
                  this.newIndicator.shine();
               }
            }
            this.badgeComponent.setData(this._badgeData.visual);
            invalidate(INV_SELECTED);
         }
         if(isInvalid(INV_SELECTED))
         {
            if(_selected)
            {
               gotoAndStop(STATE_SELECTED);
               if(this.selectedImg && StringUtils.isEmpty(this.selectedImg.source))
               {
                  this.selectedImg.source = RES_ICONS.MAPS_ICONS_LIBRARY_COMPLETEDINDICATOR;
               }
            }
            else
            {
               gotoAndStop(!!enabled ? STATE_NORMAL : STATE_DISABLED);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         if(this.selectedImg)
         {
            this.selectedImg.dispose();
            this.selectedImg = null;
         }
         if(this.badgeComponent)
         {
            this.badgeComponent.dispose();
            this.badgeComponent = null;
         }
         this.newIndicator.dispose();
         this.newIndicator = null;
         this.highlightIcon.dispose();
         this.highlightIcon = null;
         this.titleTF = null;
         this.descrTF = null;
         this.hit = null;
         this._badgeData = null;
         super.onDispose();
      }
      
      public function getBadgeID() : int
      {
         if(this._badgeData == null)
         {
            return -1;
         }
         return this._badgeData.id;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         super.selected = param1;
         invalidate(INV_SELECTED);
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         if(this._badgeData.isFirstLook)
         {
            this.newIndicator.hide();
            this._seenByUser = true;
         }
         dispatchEvent(new BadgesEvent(BadgesEvent.BADGE_RENDERER_CLICK,true));
      }
   }
}
