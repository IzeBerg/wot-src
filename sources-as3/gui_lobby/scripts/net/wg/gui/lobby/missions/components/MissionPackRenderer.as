package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUESTS_ALIASES;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.gui.lobby.missions.data.MissionsPackVO;
   import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
   import net.wg.gui.lobby.missions.interfaces.IMissionPackBody;
   import net.wg.gui.lobby.missions.interfaces.IMissionPackHeader;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionPackRenderer extends SoundListItemRenderer implements IReusableListItemRenderer
   {
      
      private static const DROP_DHADOW:DropShadowFilter = new DropShadowFilter(0,45,0,1,2,2,0.5,BitmapFilterQuality.HIGH);
      
      private static const BG_NAME:String = "bg";
      
      private static const PACK_BG_PREMIUM_LINKAGE:String = "packBgPremium";
      
      private static const PACK_BG_LINKAGE:String = "packBg";
       
      
      private var _bg:Sprite = null;
      
      private var _header:IMissionPackHeader;
      
      private var _body:IMissionPackBody;
      
      private var _currentHeaderLinkage:String;
      
      private var _currentBodyLinkage:String;
      
      private var _missionPackVO:MissionsPackVO;
      
      private var _classFactory:IClassFactory;
      
      private var _lastHeight:int;
      
      private var _nyBanner:NYMissionsBanner;
      
      public function MissionPackRenderer()
      {
         super();
         this._classFactory = App.utils.classFactory;
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         initSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         mouseChildren = true;
         stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._missionPackVO != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this._missionPackVO.blockId == QUESTS_ALIASES.MISSIONS_NY_BANNER_VIEW_ALIAS || this._missionPackVO.blockId == QUESTS_ALIASES.MISSIONS_NY_GIFT_OFF_BANNER_VIEW_ALIAS)
               {
                  if(this._body)
                  {
                     this.removeCmp(this._body);
                     this._body = null;
                     this._currentBodyLinkage = Values.EMPTY_STR;
                  }
                  if(this._header)
                  {
                     this.removeCmp(this._header);
                     this._header.removeEventListener(MissionHeaderEvent.COLLAPSE,this.onHeaderCollapseHandler);
                     this._header = null;
                     this._currentHeaderLinkage = Values.EMPTY_STR;
                  }
                  if(this._bg)
                  {
                     removeChild(this._bg);
                     this._bg = null;
                  }
                  if(this._nyBanner && this._nyBanner.name != this._missionPackVO.blockId)
                  {
                     removeChild(this._nyBanner);
                     this._nyBanner = null;
                  }
                  if(!this._nyBanner)
                  {
                     this._nyBanner = App.utils.classFactory.getComponent(this._missionPackVO.blockId,NYMissionsBanner);
                     this._nyBanner.name = this._missionPackVO.blockId;
                     addChild(this._nyBanner);
                     this._nyBanner.validateNow();
                  }
                  else
                  {
                     this._nyBanner.visible = true;
                  }
               }
               else
               {
                  if(this._nyBanner)
                  {
                     this._nyBanner.visible = false;
                  }
                  this.updateBodyComponent(this._missionPackVO.bodyLinkage);
                  this.updateHeaderComponent(this._missionPackVO.headerLinkage);
                  this._header.update(this._missionPackVO.headerData);
                  if(this._missionPackVO.isLinkedSet)
                  {
                     this._body.update(this._missionPackVO.bodyDataLinkedSet);
                  }
                  else if(this._missionPackVO.isPremium)
                  {
                     this._body.update(this._missionPackVO.bodyDataPremium);
                  }
                  else
                  {
                     this._body.update(this._missionPackVO.bodyData);
                  }
                  this._body.setCollapsed(this._missionPackVO.isCollapsed,false);
                  this._header.setCollapsed(this._missionPackVO.isCollapsed,false);
                  this._body.validateNow();
                  this._header.validateNow();
                  if(this._bg == null)
                  {
                     this._bg = Sprite(App.utils.classFactory.getObject(!!this._missionPackVO.isPremium ? PACK_BG_PREMIUM_LINKAGE : PACK_BG_LINKAGE));
                     this._bg.filters = [DROP_DHADOW];
                     this._bg.mouseEnabled = true;
                     this._bg.mouseChildren = false;
                     this._bg.name = BG_NAME;
                     addChildAt(this._bg,0);
                  }
                  this._bg.alpha = this._missionPackVO.bgAlpha;
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.updateSize();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         if(stage)
         {
            stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         }
         if(this._nyBanner)
         {
            this._nyBanner.dispose();
            this._nyBanner = null;
         }
         this._bg = null;
         if(this._header)
         {
            this.removeCmp(this._header);
            this._header.removeEventListener(MissionHeaderEvent.COLLAPSE,this.onHeaderCollapseHandler);
            this._header = null;
         }
         this.removeCmp(this._body);
         this._body = null;
         this._missionPackVO = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function cleanUp() : void
      {
      }
      
      private function updateSize() : void
      {
         var _loc1_:int = _width;
         setActualScale(1,1);
         _width = _loc1_;
         if(this._header)
         {
            this._header.width = _width;
            this._header.validateNow();
         }
         if(this._body)
         {
            this._body.width = _width;
            this._body.validateNow();
         }
         if(this._header && this._body)
         {
            if(this._body.visible)
            {
               height = this._header.height + this._body.height | 0;
               this._body.y = this._header.height | 0;
            }
            else
            {
               height = this._header.height;
               this._body.y = 0;
            }
         }
         if(this._bg != null)
         {
            this._bg.width = _width;
            this._bg.height = _height;
         }
         if(this._nyBanner && (this._missionPackVO.blockId == QUESTS_ALIASES.MISSIONS_NY_BANNER_VIEW_ALIAS || this._missionPackVO.blockId == QUESTS_ALIASES.MISSIONS_NY_GIFT_OFF_BANNER_VIEW_ALIAS))
         {
            height = this._nyBanner.getMaxHeight(_width,_height);
         }
         if(this._lastHeight != _height)
         {
            this._lastHeight = _height;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function updateHeaderComponent(param1:String) : void
      {
         if(this._currentHeaderLinkage == param1)
         {
            return;
         }
         var _loc2_:IMissionPackHeader = this._header;
         if(_loc2_)
         {
            _loc2_.removeEventListener(MissionHeaderEvent.COLLAPSE,this.onHeaderCollapseHandler);
         }
         this._header = this._classFactory.getComponent(param1,IMissionPackHeader);
         this._header.validateNow();
         this._header.addEventListener(MissionHeaderEvent.COLLAPSE,this.onHeaderCollapseHandler);
         addChild(DisplayObject(this._header));
         this._header.addEventListener(Event.RESIZE,this.onCmpResizeHandler);
         this.removeCmp(_loc2_);
         this._currentHeaderLinkage = param1;
      }
      
      private function updateBodyComponent(param1:String) : void
      {
         if(this._currentBodyLinkage == param1)
         {
            return;
         }
         var _loc2_:IMissionPackBody = this._body;
         this._body = this._classFactory.getComponent(param1,IMissionPackBody);
         addChild(DisplayObject(this._body));
         this._body.validateNow();
         this._body.addEventListener(Event.RESIZE,this.onCmpResizeHandler);
         this.removeCmp(_loc2_);
         this._currentBodyLinkage = param1;
      }
      
      private function removeCmp(param1:IUIComponentEx) : void
      {
         if(param1)
         {
            removeChild(DisplayObject(param1));
            param1.removeEventListener(Event.RESIZE,this.onCmpResizeHandler);
            param1.dispose();
         }
      }
      
      override public function set data(param1:Object) : void
      {
         this._missionPackVO = MissionsPackVO(param1);
         invalidateData();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      private function onCmpResizeHandler(param1:Event) : void
      {
         this.updateSize();
      }
      
      private function onHeaderCollapseHandler(param1:MissionHeaderEvent) : void
      {
         if(this._missionPackVO.isCollapsed == param1.isCollapsed)
         {
            return;
         }
         param1.missionId = this._missionPackVO.blockId;
         this._missionPackVO.isCollapsed = param1.isCollapsed;
         this._body.setCollapsed(this._missionPackVO.isCollapsed,true);
         this._header.setCollapsed(this._missionPackVO.isCollapsed,true);
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         this.updateSize();
      }
   }
}
