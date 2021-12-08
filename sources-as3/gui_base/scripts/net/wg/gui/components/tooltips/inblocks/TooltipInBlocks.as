package net.wg.gui.components.tooltips.inblocks
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.Separator;
   import net.wg.gui.components.tooltips.ToolTipSpecial;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.tooltips.inblocks.data.BlockDataItemVO;
   import net.wg.gui.components.tooltips.inblocks.data.TooltipInBlocksVO;
   import net.wg.gui.components.tooltips.inblocks.events.ToolTipBlockEvent;
   import net.wg.gui.components.tooltips.inblocks.interfaces.ITooltipBlock;
   import net.wg.infrastructure.interfaces.IReusable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class TooltipInBlocks extends ToolTipSpecial implements IReusable
   {
      
      private static const BG_LAYER_INDEX:int = 1;
       
      
      public var bgHighlightMc:MovieClip = null;
      
      private var _inBlocksData:TooltipInBlocksVO;
      
      private var _blocks:Vector.<ITooltipBlock>;
      
      private var _validationScheduled:Boolean = false;
      
      private var _contentHeight:Number;
      
      public function TooltipInBlocks()
      {
         super();
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         isRedrawed = false;
         super.build(param1,param2);
      }
      
      override public function cleanUp() : void
      {
         super.cleanUp();
         this.removeValidationRequesters();
         this.clearData();
         this.clearBlocks();
      }
      
      override protected function redraw() : void
      {
         super.redraw();
         this.removeValidationRequesters();
         this.clearData();
         this.clearBlocks();
         visible = false;
         App.utils.scheduler.scheduleOnNextFrame(this.scheduleValidation);
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Rectangle = null;
         var _loc2_:Number = NaN;
         if(this.isBlocksBuilt())
         {
            _loc1_ = content.getBounds(content);
            _loc2_ = _loc1_.x + _loc1_.width;
            background.width = _loc2_ + contentMargin.right + bgShadowMargin.right | 0;
            background.height = this._contentHeight + contentMargin.bottom + bgShadowMargin.bottom | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.cleanUp();
         this.bgHighlightMc = null;
         super.onDispose();
      }
      
      private function rearrangeBlocks() : void
      {
         var _loc4_:int = 0;
         var _loc1_:ITooltipBlock = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:Number = bgShadowMargin.left + contentMargin.left | 0;
         _loc4_ = this._blocks.length;
         var _loc5_:Vector.<BlockDataItemVO> = this._inBlocksData.blocksData;
         var _loc6_:PaddingVO = null;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         while(_loc8_ < _loc4_)
         {
            _loc1_ = this._blocks[_loc8_];
            _loc2_ = _loc1_.getDisplayObject();
            _loc6_ = _loc5_[_loc8_].padding;
            _loc7_ = _loc6_ != null;
            _loc2_.x = _loc3_ + (!!_loc7_ ? _loc6_.left : 0);
            _loc8_++;
         }
         updatePositions();
         var _loc9_:Number = this._inBlocksData != null ? Number(this._inBlocksData.marginAfterBlock) : Number(0);
         var _loc10_:Number = this._inBlocksData != null ? Number(this._inBlocksData.marginAfterSeparator) : Number(0);
         var _loc11_:Number = content.width + contentMargin.left + contentMargin.right;
         var _loc12_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc14_:Number = 0;
         var _loc15_:Separator = null;
         var _loc16_:DisplayObject = null;
         topPosition = bgShadowMargin.top + contentMargin.top;
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc14_ = topPosition;
            if(_loc8_ > 0)
            {
               _loc15_ = separators[_loc8_ - 1];
               _loc15_.y = topPosition | 0;
               topPosition += _loc10_;
            }
            _loc1_ = this._blocks[_loc8_];
            _loc2_ = _loc1_.getDisplayObject();
            _loc6_ = _loc5_[_loc8_].padding;
            _loc7_ = _loc6_ != null;
            topPosition += !!_loc7_ ? _loc6_.top : 0;
            _loc2_.y = topPosition | 0;
            _loc13_ = _loc8_ == _loc4_ - 1;
            topPosition += _loc1_.getHeight() + (!!_loc13_ ? 0 : _loc9_) + (!!_loc7_ ? _loc6_.bottom : 0);
            _loc16_ = _loc1_.getBg();
            _loc12_ = _loc1_.getStretchBg();
            if(_loc16_ != null)
            {
               _loc16_.x = !!_loc12_ ? Number(0) : Number(_loc3_);
               _loc16_.y = _loc14_ | 0;
               if(_loc12_)
               {
                  _loc16_.width = _loc11_;
                  _loc16_.height = topPosition - _loc14_;
                  if(_loc13_)
                  {
                     _loc16_.height += contentMargin.bottom;
                  }
               }
            }
            _loc8_++;
         }
         this._contentHeight = topPosition;
      }
      
      private function rearrangeAndUpdateSize() : void
      {
         this.rearrangeBlocks();
         this.updateSize();
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function clearBlocks() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:ITooltipBlock = null;
         if(this._blocks != null)
         {
            for each(_loc2_ in this._blocks)
            {
               _loc2_.removeEventListener(ToolTipBlockEvent.SIZE_CHANGE,this.onBlockSizeChangeHandler);
               content.removeChild(_loc2_.getDisplayObject());
               _loc1_ = _loc2_.getBg();
               if(_loc1_ != null)
               {
                  removeChild(_loc1_);
               }
               _loc2_.dispose();
            }
            this._blocks.fixed = false;
            this._blocks.splice(0,this._blocks.length);
            this._blocks = null;
         }
      }
      
      private function clearData() : void
      {
         if(this._inBlocksData != null)
         {
            this._inBlocksData.dispose();
            this._inBlocksData = null;
         }
      }
      
      private function buildBlocks() : void
      {
         var _loc1_:PaddingVO = null;
         var _loc2_:Separator = null;
         var _loc3_:ITooltipBlock = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:DisplayObject = null;
         var _loc6_:Vector.<BlockDataItemVO> = null;
         var _loc7_:int = 0;
         var _loc8_:BlockDataItemVO = null;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Utils = null;
         var _loc13_:TooltipInBlocksUtils = null;
         var _loc14_:PaddingVO = null;
         if(this._inBlocksData != null)
         {
            _loc1_ = this._inBlocksData.contentMargin;
            if(_loc1_ != null)
            {
               contentMargin.top = _loc1_.top;
               contentMargin.bottom = _loc1_.bottom;
               contentMargin.left = _loc1_.left;
               contentMargin.right = _loc1_.right;
            }
            _loc2_ = null;
            separators = new Vector.<Separator>();
            _loc6_ = this._inBlocksData.blocksData;
            _loc7_ = _loc6_.length;
            _loc10_ = this._inBlocksData.width - (contentMargin.left + contentMargin.right);
            _loc11_ = 0;
            _loc12_ = Utils.instance;
            _loc13_ = TooltipInBlocksUtils.instance;
            this._blocks = new Vector.<ITooltipBlock>(_loc7_,true);
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc8_ = _loc6_[_loc9_];
               _loc14_ = _loc8_.padding;
               if(_loc9_ > 0)
               {
                  _loc2_ = _loc12_.createSeparate(content);
                  separators.push(_loc2_);
               }
               _loc3_ = _loc13_.createBlock(_loc8_.linkage);
               _loc5_ = _loc3_.getBg();
               if(_loc5_ != null)
               {
                  addChildAt(_loc5_,BG_LAYER_INDEX);
               }
               this._blocks[_loc9_] = _loc3_;
               _loc11_ = _loc8_.blockWidth > 0 ? Number(_loc8_.blockWidth) : Number(_loc10_);
               _loc3_.setBlockWidth(_loc11_ - (_loc14_ != null ? _loc14_.left + _loc14_.right : 0));
               _loc3_.setBlockData(_loc8_.data);
               _loc3_.addEventListener(ToolTipBlockEvent.SIZE_CHANGE,this.onBlockSizeChangeHandler);
               _loc4_ = _loc3_.getDisplayObject();
               content.addChild(_loc4_);
               _loc9_++;
            }
            this.bgHighlightMc.visible = StringUtils.isNotEmpty(this._inBlocksData.highlightType);
            if(this.bgHighlightMc.visible)
            {
               this.bgHighlightMc.gotoAndStop(this._inBlocksData.highlightType);
            }
         }
      }
      
      private function tryValidateBlocks() : void
      {
         var _loc1_:ITooltipBlock = null;
         for each(_loc1_ in this._blocks)
         {
            if(_loc1_.isBlockInvalid())
            {
               _loc1_.tryValidateBlock();
            }
         }
      }
      
      private function isInvalidBlocks() : Boolean
      {
         var _loc1_:ITooltipBlock = null;
         for each(_loc1_ in this._blocks)
         {
            if(_loc1_.isBlockInvalid())
            {
               return true;
            }
         }
         return false;
      }
      
      private function isBlocksDataParsed() : Boolean
      {
         return this._inBlocksData != null;
      }
      
      private function isBlocksBuilt() : Boolean
      {
         return this._blocks != null && this._blocks.length > 0;
      }
      
      private function scheduleValidation() : void
      {
         if(!this._validationScheduled)
         {
            addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this._validationScheduled = true;
         }
      }
      
      private function unscheduleValidation() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         this._validationScheduled = false;
      }
      
      override protected function get isBeginShowAfterRedraw() : Boolean
      {
         return false;
      }
      
      public function get contentHeight() : Number
      {
         return this._contentHeight;
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         if(!this.isBlocksDataParsed())
         {
            this._inBlocksData = new TooltipInBlocksVO(_data);
            if(this._inBlocksData.blocksData == null)
            {
               this.removeValidationRequesters();
               App.utils.asserter.assert(false,"Blocks data" + Errors.CANT_EMPTY + ", tooltipType: " + _type + ", component: " + _component);
            }
         }
         else if(!this.isBlocksBuilt())
         {
            this.buildBlocks();
         }
         else if(this.isInvalidBlocks())
         {
            this.tryValidateBlocks();
         }
         else
         {
            this.removeValidationRequesters();
            this.rearrangeAndUpdateSize();
            beginShow();
         }
      }
      
      private function onBlockSizeChangeHandler(param1:ToolTipBlockEvent) : void
      {
         this.scheduleValidation();
      }
      
      private function removeValidationRequesters() : void
      {
         App.utils.scheduler.cancelTask(this.scheduleValidation);
         this.unscheduleValidation();
      }
   }
}
