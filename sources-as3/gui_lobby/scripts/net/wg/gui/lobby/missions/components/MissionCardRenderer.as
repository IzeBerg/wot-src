package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.interfaces.IReusableListItemRenderer;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.missions.data.MissionCardViewVO;
   import net.wg.gui.lobby.missions.data.MissionConditionsContainerVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ListEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class MissionCardRenderer extends SoundListItemRenderer implements IReusableListItemRenderer
   {
      
      private static const CONDITIONS_TOP_OFFSET:Number = 62;
      
      private static const DISABLED_ALPHA:Number = 0.7;
      
      private static const DEFAULT_OFFSET:int = 20;
      
      private static const SMALL_AWARDS_HEIGHT:int = 50;
      
      private static const SMALL_AWARDS_GAP:int = 20;
      
      private static const AWARD_RENDERER_WIDTH:Number = 48;
      
      private static const AWARD_RENDERER_HEIGHT:Number = 48;
      
      private static const INVALID_LAYOUT:String = "invalidLayout";
      
      private static const CONDITIONS_MARGIN:int = 15;
      
      private static const INVALID_DATA:String = "invalidData";
       
      
      public var titleTFHit:Sprite;
      
      public var progressDescTFHit:Sprite;
      
      public var titleTF:TextField = null;
      
      public var progressDescTF:TextField = null;
      
      public var awardsGroup:IGroupEx = null;
      
      public var awardsBg:DisplayObject;
      
      public var uiDecoration:IImage = null;
      
      public var background:MovieClip = null;
      
      public var hitMc:MovieClip = null;
      
      private var _rendererData:MissionCardViewVO;
      
      private var _conditionsContainers:Vector.<DisplayObject> = null;
      
      private var _enabled:Boolean = true;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _isTitleTruncated:Boolean = false;
      
      private var _titleTooltip:String;
      
      private var _classFactory:IClassFactory;
      
      public function MissionCardRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._classFactory = App.utils.classFactory;
         super();
         preventAutosizing = true;
         this._conditionsContainers = new Vector.<DisplayObject>();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useHandCursor = true;
         mouseChildren = true;
         this.hitMc.mouseEnabled = true;
         this.hitMc.buttonMode = true;
         this.titleTFHit.buttonMode = true;
         this.progressDescTFHit.buttonMode = true;
         this.awardsGroup.layout = new CenterAlignedGroupLayout(AWARD_RENDERER_WIDTH,AWARD_RENDERER_HEIGHT);
         this.awardsGroup.itemRendererLinkage = Linkages.AWARD_RENDERER;
         this.titleTFHit.addEventListener(MouseEvent.ROLL_OVER,this.onTitleTFRollOverHandler);
         this.titleTFHit.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.progressDescTFHit.addEventListener(MouseEvent.ROLL_OVER,this.onProgressDescTFRollOverHandler);
         this.progressDescTFHit.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         TextFieldEx.setVerticalAlign(this.progressDescTF,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         super.draw();
         if(this._rendererData != null && isInvalid(INVALID_DATA))
         {
            this.titleTF.htmlText = this._rendererData.title;
            this._titleTooltip = this.titleTF.text;
            _loc1_ = App.utils.commons.truncateTextFieldText(this.titleTF,this._rendererData.title,true,true);
            this._isTitleTruncated = _loc1_.length < this._rendererData.title.length;
            this.progressDescTF.htmlText = this._rendererData.statusLabel;
            this.background.gotoAndStop(this._rendererData.background);
            this.uiDecoration.visible = StringUtils.isNotEmpty(this._rendererData.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = this._rendererData.uiDecoration;
            }
            this.invalidateConditions();
            if(this._rendererData.awards.length > 0)
            {
               this.invalidateAwards();
            }
            this.enabled = this._rendererData.isAvailable;
         }
         if(this._conditionsContainers && this._conditionsContainers.length > 0 && isInvalid(INVALID_LAYOUT))
         {
            _loc2_ = CONDITIONS_TOP_OFFSET;
            _loc3_ = this._conditionsContainers.length;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = this._conditionsContainers[_loc5_];
               _loc4_.y = _loc2_;
               _loc4_.x = CONDITIONS_MARGIN;
               _loc4_.width = width - (CONDITIONS_MARGIN << 1);
               _loc2_ = _loc4_.y + _loc4_.height;
               _loc4_.visible = true;
               _loc5_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.titleTFHit.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleTFRollOverHandler);
         this.titleTFHit.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.progressDescTFHit.removeEventListener(MouseEvent.ROLL_OVER,this.onProgressDescTFRollOverHandler);
         this.progressDescTFHit.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this.cleanUpConditions();
         this._conditionsContainers = null;
         this.awardsGroup.dispose();
         this.awardsGroup = null;
         this.titleTF = null;
         this.progressDescTF = null;
         this.background = null;
         this.awardsBg = null;
         this._rendererData = null;
         this._toolTipMgr = null;
         this.hitMc = null;
         this.titleTFHit = null;
         this.progressDescTFHit = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      override protected function handleClick(param1:uint = 0) : void
      {
         super.handleClick(param1);
         dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK,true,false,_index,-1,-1,this,this._rendererData));
      }
      
      public function cleanUp() : void
      {
      }
      
      private function invalidateConditions() : void
      {
         var _loc3_:MissionConditionsContainerVO = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         var _loc1_:Vector.<MissionConditionsContainerVO> = this._rendererData.battleConditions;
         var _loc2_:int = _loc1_.length;
         if(_loc2_ > 0)
         {
            this.cleanUpConditions();
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc3_ = MissionConditionsContainerVO(_loc1_[_loc5_]);
               _loc4_ = this._classFactory.getComponent(_loc3_.linkage,DisplayObject);
               _loc4_.visible = false;
               IUpdatable(_loc4_).update(_loc3_);
               _loc4_.addEventListener(Event.RESIZE,this.onContainerResizeHandler);
               this._conditionsContainers.push(addChild(_loc4_));
               _loc5_++;
            }
            invalidate(INVALID_LAYOUT);
         }
      }
      
      private function invalidateAwards() : void
      {
         this.awardsGroup.visible = false;
         CenterAlignedGroupLayout(this.awardsGroup.layout).gap = SMALL_AWARDS_GAP;
         this.awardsGroup.dataProvider = this._rendererData.awards;
         UIComponent(this.awardsGroup).setSize(width - (DEFAULT_OFFSET << 1),SMALL_AWARDS_HEIGHT);
         this.awardsGroup.x = width - this.awardsGroup.width >> 1;
         this.awardsGroup.y = this.awardsBg.y + (this.awardsBg.height - this.awardsGroup.height >> 1);
         this.awardsGroup.visible = true;
      }
      
      private function cleanUpConditions() : void
      {
         var _loc1_:UIComponent = null;
         if(this._conditionsContainers.length > 0)
         {
            for each(_loc1_ in this._conditionsContainers)
            {
               _loc1_.removeEventListener(Event.RESIZE,this.onContainerResizeHandler);
               this.removeChild(_loc1_);
               _loc1_.dispose();
            }
            this._conditionsContainers.splice(0,this._conditionsContainers.length);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._rendererData != param1)
         {
            this._rendererData = MissionCardViewVO(param1);
            invalidate(INVALID_DATA);
         }
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(this._enabled == param1)
         {
            return;
         }
         this.alpha = !!param1 ? Number(1) : Number(DISABLED_ALPHA);
         this._enabled = param1;
      }
      
      private function onTitleTFRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isTitleTruncated)
         {
            this._toolTipMgr.show(this._titleTooltip);
         }
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onProgressDescTFRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ToolTipVO = this._rendererData.statusTooltipData;
         if(_loc2_.isSpecial)
         {
            this._toolTipMgr.showSpecial.apply(this,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
         }
         else
         {
            this._toolTipMgr.showComplex(_loc2_.tooltip);
         }
      }
      
      private function onContainerResizeHandler(param1:Event) : void
      {
         invalidate(INVALID_LAYOUT);
      }
   }
}
