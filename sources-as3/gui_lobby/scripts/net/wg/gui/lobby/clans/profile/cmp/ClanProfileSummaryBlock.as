package net.wg.gui.lobby.clans.profile.cmp
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.interfaces.IDashLineTextItem;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileStatsLineVO;
   import net.wg.gui.lobby.clans.profile.VOs.ClanProfileSummaryBlockVO;
   import net.wg.gui.lobby.clans.profile.interfaces.IClanProfileSummaryBlock;
   import net.wg.gui.lobby.clans.profile.interfaces.ITextFieldFrame;
   import net.wg.gui.lobby.clans.utils.ClanHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipFormatter;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class ClanProfileSummaryBlock extends UIComponentEx implements IClanProfileSummaryBlock
   {
      
      private static const Y_POS_WITHOUT_HEADER:int = 30;
      
      private static const Y_POS_WITH_LEAGUES:int = 80;
      
      private static const EMPTY_FIELD_PADDING:int = 45;
      
      private static const EMPTY_FIELD_HEIGHT:int = 56;
      
      private static const RENDER_PADDING:int = 24;
      
      private static const DYN_PADDING:int = 5;
       
      
      public var titleTF:TextField = null;
      
      private var _dynItems:Vector.<DisplayObject> = null;
      
      private var _isShowHeader:Boolean = false;
      
      private var _isLeaguesEnabled:Boolean = false;
      
      private var _dynHeight:int = 0;
      
      private var _utils:IClassFactory = null;
      
      private var _commons:ICommons = null;
      
      private var _clanHelper:ClanHelper = null;
      
      public function ClanProfileSummaryBlock()
      {
         super();
         this._clanHelper = new ClanHelper();
         this._utils = App.utils.classFactory;
         this.titleTF.visible = false;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this._commons = App.utils.commons;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._isShowHeader && isInvalid(InvalidationType.SIZE))
         {
            this.updateHeaderPosition();
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearContent();
         this._utils = null;
         this.titleTF = null;
         this._clanHelper.dispose();
         this._clanHelper = null;
         this._commons = null;
         super.onDispose();
      }
      
      public function getDynHeight() : int
      {
         return this._dynHeight;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:ClanProfileSummaryBlockVO = ClanProfileSummaryBlockVO(param1);
         this._isShowHeader = _loc2_.isShowHeader;
         if(this._isShowHeader)
         {
            this.titleTF.visible = true;
            this.titleTF.htmlText = _loc2_.header;
            this._commons.updateTextFieldSize(this.titleTF,false,true);
         }
         else
         {
            this.titleTF.visible = false;
         }
         this.clearContent();
         this._dynItems = new Vector.<DisplayObject>();
         if(_loc2_.isActivated)
         {
            this.makeActivatedBlocks(_loc2_);
         }
         else
         {
            this.makeDisabledBlock(_loc2_);
         }
         invalidateSize();
      }
      
      public function set isLeaguesEnabled(param1:Boolean) : void
      {
         this._isLeaguesEnabled = param1;
      }
      
      private function createComplexTooltipStr(param1:String, param2:String) : String
      {
         var _loc3_:ITooltipFormatter = App.toolTipMgr.getNewFormatter();
         _loc3_.addHeader(param1);
         _loc3_.addBody(param2);
         return _loc3_.make();
      }
      
      private function updateHeaderPosition() : void
      {
         this.titleTF.x = this._clanHelper.getPositionOfCenter(this,this.titleTF.width);
      }
      
      private function makeDisabledBlock(param1:ClanProfileSummaryBlockVO) : void
      {
         var _loc2_:ITextFieldFrame = this._utils.getComponent(Linkages.TEXT_FIELD_FRAME_UI,ITextFieldFrame);
         this.addChild(DisplayObject(_loc2_));
         var _loc3_:int = !!this._isLeaguesEnabled ? int(Y_POS_WITH_LEAGUES) : int(0);
         var _loc4_:int = this.titleTF.y + this.titleTF.height + _loc3_ + EMPTY_FIELD_PADDING ^ 0;
         this.updateItemPosition(_loc2_,_loc4_);
         _loc2_.label = param1.emptyLbl;
         _loc2_.height = EMPTY_FIELD_HEIGHT;
         _loc2_.imageSource = RES_ICONS.MAPS_ICONS_CLANS_TEXTFIELDRECT;
         this._dynHeight = _loc2_.y + _loc2_.height + DYN_PADDING ^ 0;
         this._dynItems.push(_loc2_);
      }
      
      private function clearContent() : void
      {
         var _loc1_:IDisposable = null;
         if(this._dynItems)
         {
            for each(_loc1_ in this._dynItems)
            {
               _loc1_.dispose();
               this.removeChild(DisplayObject(_loc1_));
            }
            this._dynItems.splice(0,this._dynItems.length);
            this._dynItems = null;
         }
      }
      
      private function makeActivatedBlocks(param1:ClanProfileSummaryBlockVO) : void
      {
         var _loc6_:ClanProfileStatsLineVO = null;
         var _loc7_:IDashLineTextItem = null;
         var _loc2_:int = param1.statBlocks.length;
         var _loc3_:int = !!this._isLeaguesEnabled ? int(Y_POS_WITH_LEAGUES) : int(0);
         var _loc4_:int = (!!this._isShowHeader ? Y_POS_WITHOUT_HEADER : 0) + _loc3_;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = param1.getBlockAt(_loc5_);
            _loc7_ = this._utils.getComponent(Linkages.DASH_LINE_TEXT_ITEM,IDashLineTextItem);
            this.addChild(_loc7_ as DisplayObject);
            this.updateItemPosition(_loc7_,_loc4_);
            _loc4_ += RENDER_PADDING;
            this.updateBlockProperties(_loc7_,_loc6_);
            this._dynItems.push(_loc7_);
            _loc5_++;
         }
         this._dynHeight = _loc4_;
      }
      
      private function updateBlockProperties(param1:IDashLineTextItem, param2:ClanProfileStatsLineVO) : void
      {
         param1.label = param2.label;
         var _loc3_:String = Values.EMPTY_STR;
         if(param2.isUseTextStyle)
         {
            param1.useTruncateValues(param2.truncateVo);
            _loc3_ = this.createComplexTooltipStr("",param2.value);
         }
         else
         {
            _loc3_ = this.createComplexTooltipStr(param2.tooltipHeader,param2.tooltipBody);
         }
         param1.tooltip = _loc3_;
         param1.value = param2.value;
         param1.visible = !param2.isHidden;
         param1.invalidate(InvalidationType.ALL);
      }
      
      private function updateItemPosition(param1:IUIComponentEx, param2:int) : void
      {
         param1.x = 0;
         param1.y = param2;
         param1.width = this._width ^ 0;
      }
   }
}
