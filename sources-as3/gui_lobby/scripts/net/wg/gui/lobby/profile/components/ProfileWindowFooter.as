package net.wg.gui.lobby.profile.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.dogtag.DogtagComponent;
   import net.wg.gui.lobby.profile.ProfileOpenInfoEvent;
   import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.events.ButtonEvent;
   
   public class ProfileWindowFooter extends ProfileFooter
   {
      
      private static const BACKGROUND_HIT_AREA_WIDTH_MULT:Number = 0.42;
      
      private static const LAYOUT_INVALID:String = "layInv";
      
      private static const HEIGHT:int = 181;
      
      private static const TOP_GAP:int = 25;
      
      private static const SIDES_GAP:uint = 10;
      
      private static const DOG_TAG_COMPONENT_GAP:int = 210;
      
      private static const DOG_TAG_GROUP_GAP:int = 20;
       
      
      public var registerDateTf:TextField = null;
      
      public var lastBattleTf:TextField = null;
      
      public var noGroupsTf:TextField = null;
      
      public var background:Sprite = null;
      
      public var noGroupsProxy:Sprite = null;
      
      private var _clanGroupBlock:ProfileGroupBlock = null;
      
      private var _clan:ProfileGroupBlockVO = null;
      
      private var _clanEmblem:String = null;
      
      private var _dogTag:DogtagComponent = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _backgroundHitTest:Sprite = null;
      
      private var _engravingHitTest:Sprite = null;
      
      public function ProfileWindowFooter()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.registerDateTf.autoSize = TextFieldAutoSize.LEFT;
         this.lastBattleTf.autoSize = TextFieldAutoSize.LEFT;
         this.registerDateTf.selectable = this.lastBattleTf.selectable = false;
         this.registerDateTf.x = SIDES_GAP;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(LAYOUT_INVALID))
         {
            this.lastBattleTf.x = this.width - this.lastBattleTf.width - SIDES_GAP;
            this.noGroupsProxy.visible = this.noGroupsTf.visible = false;
            if(data)
            {
               if(this._clan)
               {
                  this._clanGroupBlock.y = TOP_GAP;
                  if(this._dogTag)
                  {
                     this._clanGroupBlock.x = this._dogTag.x + this._dogTag.width + DOG_TAG_GROUP_GAP;
                  }
                  else
                  {
                     this._clanGroupBlock.x = width - this._clanGroupBlock.width >> 1;
                  }
               }
               else
               {
                  this.noGroupsProxy.visible = this.noGroupsTf.visible = true;
                  this.noGroupsTf.text = PROFILE.PROFILE_SUMMARY_NOGROUPS;
                  if(this._dogTag)
                  {
                     this.noGroupsTf.autoSize = TextFieldAutoSize.LEFT;
                     this.noGroupsTf.x = this._dogTag.x + this._dogTag.width + DOG_TAG_GROUP_GAP;
                  }
               }
            }
         }
      }
      
      override protected function applyDataChanges() : void
      {
         super.applyDataChanges();
         this.lastBattleTf.htmlText = data.lastBattleDate;
         this.registerDateTf.htmlText = data.registrationDate;
         this.updateClanBlock();
         if(!this._dogTag && data.dogTag)
         {
            this._dogTag = App.utils.classFactory.getComponent(Linkages.DOGTAG,DogtagComponent);
            this._dogTag.goToLabel(DogtagComponent.DOGTAG_LABEL_END_TOP);
            this._dogTag.setDogTagInfo(data.dogTag);
            this._dogTag.hideNameAndClan();
            this._dogTag.y = (this.noGroupsProxy.height >> 1) - (this._dogTag.height >> 1);
            this._dogTag.x = DOG_TAG_COMPONENT_GAP;
            addChild(this._dogTag);
            this._backgroundHitTest = new Sprite();
            this._backgroundHitTest.graphics.beginFill(16711680);
            this._backgroundHitTest.graphics.drawRect(0,0,this._dogTag.width * BACKGROUND_HIT_AREA_WIDTH_MULT,this._dogTag.height);
            this._backgroundHitTest.graphics.endFill();
            this._backgroundHitTest.alpha = 0;
            this._backgroundHitTest.x = this._dogTag.x;
            this._backgroundHitTest.y = this._dogTag.y;
            this._backgroundHitTest.addEventListener(MouseEvent.ROLL_OVER,this.onDTBackgroundTestRollOver);
            this._backgroundHitTest.addEventListener(MouseEvent.ROLL_OUT,this.onDTRollOutHandler);
            addChild(this._backgroundHitTest);
            this._engravingHitTest = new Sprite();
            this._engravingHitTest.graphics.beginFill(65280);
            this._engravingHitTest.graphics.drawRect(0,0,this._dogTag.width - this._backgroundHitTest.width,this._dogTag.height);
            this._engravingHitTest.graphics.endFill();
            this._engravingHitTest.alpha = 0;
            this._engravingHitTest.x = this._backgroundHitTest.x + this._backgroundHitTest.width;
            this._engravingHitTest.y = this._backgroundHitTest.y;
            this._engravingHitTest.addEventListener(MouseEvent.ROLL_OVER,this.onDTEngravingTestRollOver);
            this._engravingHitTest.addEventListener(MouseEvent.ROLL_OUT,this.onDTRollOutHandler);
            addChild(this._engravingHitTest);
         }
         invalidate(LAYOUT_INVALID);
      }
      
      private function onDTBackgroundTestRollOver(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.DOG_TAGS_INFO,null,data.dogTag.background.componentID);
      }
      
      private function onDTEngravingTestRollOver(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.DOG_TAGS_INFO,null,data.dogTag.engraving.componentID,data.userID);
      }
      
      private function onDTRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      override protected function onDispose() : void
      {
         this.removeClanBlock();
         this.lastBattleTf = null;
         this.registerDateTf = null;
         this.background = null;
         this.noGroupsTf = null;
         this.noGroupsProxy = null;
         this._clan = null;
         if(this._dogTag)
         {
            this._dogTag.dispose();
            this._dogTag = null;
            this._backgroundHitTest.removeEventListener(MouseEvent.ROLL_OVER,this.onDTBackgroundTestRollOver);
            this._backgroundHitTest.removeEventListener(MouseEvent.ROLL_OUT,this.onDTRollOutHandler);
            this._backgroundHitTest = null;
            this._engravingHitTest.removeEventListener(MouseEvent.ROLL_OVER,this.onDTEngravingTestRollOver);
            this._engravingHitTest.removeEventListener(MouseEvent.ROLL_OUT,this.onDTRollOutHandler);
            this._engravingHitTest = null;
         }
         super.onDispose();
      }
      
      public function setClanData(param1:ProfileGroupBlockVO) : void
      {
         this._clan = param1;
         invalidateData();
      }
      
      public function setClanEmblem(param1:String) : void
      {
         this._clanEmblem = param1;
         if(this._clanGroupBlock)
         {
            this._clanGroupBlock.setEmblem(param1);
         }
      }
      
      private function createGroupBlock() : ProfileGroupBlock
      {
         var _loc1_:ProfileGroupBlock = ProfileGroupBlock(App.utils.classFactory.getComponent(Linkages.PROFILE_GROUP_BLOCK,ProfileGroupBlock));
         this.addChild(_loc1_);
         _loc1_.visible = false;
         return _loc1_;
      }
      
      private function updateClanBlock() : void
      {
         if(this._clan)
         {
            if(this._clanGroupBlock == null)
            {
               this._clanGroupBlock = this.createGroupBlock();
               this._clanGroupBlock.actionBtn.addEventListener(ButtonEvent.CLICK,this.onClanGroupBlockActionBtnClickHandler);
               App.utils.scheduler.scheduleOnNextFrame(this.updateClanData);
               invalidate(LAYOUT_INVALID);
            }
            else
            {
               this.updateClanData();
            }
         }
         else
         {
            this.removeClanBlock();
            invalidate(LAYOUT_INVALID);
         }
      }
      
      private function updateClanData() : void
      {
         this._clanGroupBlock.setData(this._clan);
         this._clanGroupBlock.setEmblem(this._clanEmblem);
         this._clanGroupBlock.visible = true;
      }
      
      private function removeClanBlock() : void
      {
         if(this._clanGroupBlock)
         {
            App.utils.scheduler.cancelTask(this.updateClanData);
            this._clanGroupBlock.actionBtn.removeEventListener(ButtonEvent.CLICK,this.onClanGroupBlockActionBtnClickHandler);
            removeChild(this._clanGroupBlock);
            this._clanGroupBlock.dispose();
            this._clanGroupBlock = null;
         }
      }
      
      override public function get height() : Number
      {
         return HEIGHT;
      }
      
      private function onClanGroupBlockActionBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ProfileOpenInfoEvent(ProfileOpenInfoEvent.CLAN));
      }
   }
}
