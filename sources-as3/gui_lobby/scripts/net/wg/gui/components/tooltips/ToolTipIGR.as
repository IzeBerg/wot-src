package net.wg.gui.components.tooltips
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.IgrVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   
   public class ToolTipIGR extends ToolTipSpecial
   {
      
      private static var UI_igrQuestBlock:String = "igrQuestBlockUI";
      
      private static var UI_igrQuestProgress:String = "igrQuestProgressUI";
      
      private static var UI_igrPremVehQuestBlock:String = "igrPremVehQuestBlockUI";
       
      
      public var headerTF:TextField = null;
      
      public var discrTF:TextField = null;
      
      public var whiteBg:Sprite = null;
      
      private var progressBlock:IgrQuestProgressBlock = null;
      
      private var igrPremVehQuestBlocks:Vector.<IgrPremVehQuestBlock> = null;
      
      public function ToolTipIGR()
      {
         super();
         this.headerTF = content.headerTF;
         this.discrTF = content.discrTF;
         this.whiteBg = content.whiteBg;
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.progressBlock)
         {
            content.removeChild(this.progressBlock);
            this.progressBlock = null;
         }
         if(this.igrPremVehQuestBlocks)
         {
            this.igrPremVehQuestBlocks.splice(0,this.igrPremVehQuestBlocks.length);
            this.igrPremVehQuestBlocks = null;
         }
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipIGR " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function redraw() : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:IgrVO = null;
         var _loc6_:Separator = null;
         var _loc9_:IgrQuestBlock = null;
         var _loc11_:Boolean = false;
         var _loc12_:IgrPremVehQuestBlock = null;
         var _loc1_:ILocale = App.utils.locale;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         _loc4_ = 300;
         _loc5_ = new IgrVO(_data);
         _loc6_ = null;
         separators = new Vector.<Separator>();
         contentMargin.bottom = 2;
         var _loc7_:ToolTipBlockResultVO = null;
         blockResults = new Vector.<ToolTipBlockResultVO>();
         this.whiteBg.width = 10;
         topPosition = bgShadowMargin.top + contentMargin.top;
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         this.headerTF.htmlText = Utils.instance.htmlWrapper(_loc5_.title,Utils.instance.COLOR_HEADER,18,"$TitleFont");
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         _loc4_ = Math.max(_loc4_,this.headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
         _loc6_ = Utils.instance.createSeparate(content);
         _loc6_.y = topPosition | 0;
         separators.push(_loc6_);
         topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         if(_loc5_.description)
         {
            this.whiteBg.y = topPosition - Utils.instance.MARGIN_AFTER_SEPARATE;
            this.discrTF.autoSize = TextFieldAutoSize.LEFT;
            this.discrTF.htmlText = Utils.instance.htmlWrapper(_loc5_.description,Utils.instance.COLOR_NORMAL,12,"$FieldFont");
            this.discrTF.width = _loc4_ != 0 ? Number(_loc4_ - bgShadowMargin.left - contentMargin.left) : Number(this.discrTF.textWidth + 5);
            this.discrTF.x = bgShadowMargin.left + contentMargin.left;
            this.discrTF.y = topPosition;
            topPosition += this.discrTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            this.whiteBg.height = topPosition - this.whiteBg.y;
         }
         else
         {
            this.discrTF.x = 0;
            this.discrTF.y = 0;
            this.discrTF.width = 10;
            this.discrTF.visible = false;
         }
         var _loc8_:int = _loc5_.quests.length;
         var _loc10_:Class = App.utils.classFactory.getClass(UI_igrQuestBlock);
         if(_loc5_.quests && _loc5_.quests.length > 0)
         {
            _loc8_ = _loc5_.quests.length;
            _loc2_ = 0;
            while(_loc2_ < _loc8_)
            {
               _loc9_ = new _loc10_();
               content.addChild(_loc9_);
               _loc9_.questText.width = _loc4_ != 0 ? Number(_loc4_ - bgShadowMargin.left - contentMargin.left) : Number(_loc9_.questText.textWidth + 5);
               _loc9_.setText(_loc5_.quests[_loc2_]);
               _loc9_.x = bgShadowMargin.left + contentMargin.left;
               _loc9_.y = topPosition;
               topPosition += _loc9_.height;
               _loc2_++;
            }
            topPosition += Utils.instance.MARGIN_AFTER_BLOCK;
            this.whiteBg.height = topPosition - this.whiteBg.y;
         }
         if(_loc5_.progress && _loc5_.progress.length > 0)
         {
            _loc6_ = Utils.instance.createSeparate(content);
            _loc6_.y = topPosition | 0;
            separators.push(_loc6_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            this.progressBlock = App.utils.classFactory.getComponent(UI_igrQuestProgress,IgrQuestProgressBlock);
            content.addChild(this.progressBlock);
            this.progressBlock.setData(_loc5_.progressHeader,_loc5_.progress);
            this.progressBlock.width = _loc4_ != 0 ? Number(_loc4_ - bgShadowMargin.left - contentMargin.left) : Number(this.progressBlock.width);
            this.progressBlock.x = bgShadowMargin.left + contentMargin.left;
            this.progressBlock.y = topPosition;
            topPosition += this.progressBlock.height + Utils.instance.MARGIN_AFTER_BLOCK;
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_LASTITEM;
         }
         if(_loc5_.premVehQuests && _loc5_.premVehQuests.length > 0)
         {
            this.igrPremVehQuestBlocks = new Vector.<IgrPremVehQuestBlock>();
            _loc3_ = _loc5_.premVehQuests.length;
            _loc11_ = false;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(_loc5_.premVehQuests[_loc2_].hasOwnProperty("header") && _loc5_.premVehQuests[_loc2_].hasOwnProperty("descr") && _loc5_.premVehQuests[_loc2_].header != Values.EMPTY_STR && _loc5_.premVehQuests[_loc2_].descr != Values.EMPTY_STR)
               {
                  _loc11_ = true;
                  _loc6_ = Utils.instance.createSeparate(content);
                  _loc6_.y = topPosition | 0;
                  separators.push(_loc6_);
                  topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
                  _loc12_ = App.utils.classFactory.getComponent(UI_igrPremVehQuestBlock,IgrPremVehQuestBlock);
                  content.addChild(_loc12_);
                  _loc12_.setData(_loc5_.premVehQuests[_loc2_].header,_loc5_.premVehQuests[_loc2_].descr);
                  this.igrPremVehQuestBlocks.push(_loc12_);
                  _loc12_.x = bgShadowMargin.left + contentMargin.left;
                  _loc12_.y = topPosition;
                  topPosition += _loc12_.height + Utils.instance.MARGIN_AFTER_BLOCK;
               }
               _loc2_++;
            }
            if(_loc11_)
            {
               contentMargin.bottom = Utils.instance.MARGIN_AFTER_LASTITEM;
            }
         }
         _loc5_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         this.whiteBg.width = content.width + bgShadowMargin.horizontal;
      }
   }
}
