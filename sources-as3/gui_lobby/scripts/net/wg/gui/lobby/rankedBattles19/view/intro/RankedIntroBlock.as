package net.wg.gui.lobby.rankedBattles19.view.intro
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroBlockVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedIntroBlock extends Sprite implements IDisposable
   {
      
      private static const LINE_ADDITIONAL_HEIGHT:int = 20;
      
      private static const TF_HORIZONTAL_PADDING_BIG:int = 28;
      
      private static const TF_HORIZONTAL_PADDING_SMALL:int = 18;
      
      private static const ALLOW_BLOCK_WIDTH_WIDE:int = 348;
      
      private static const ALLOW_BLOCK_WIDTH_MEDIUM:int = 326;
      
      private static const ALLOW_BLOCK_WIDTH_SHORT:int = 285;
      
      private static const TITLE_FONT_SIZE_BIG:int = 24;
      
      private static const TITLE_FONT_SIZE_SMALL:int = 16;
      
      private static const DESCR_FONT_SIZE_BIG:int = 16;
      
      private static const DESCR_FONT_SIZE_SMALL:int = 14;
      
      private static const DESCR_TOP_OFFSET_SMALL:int = 30;
      
      private static const DESCR_TOP_OFFSET_BIG:int = 37;
      
      private static const TF_BORDER_PADDING:Number = 2;
       
      
      public var titleTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      public var line:Sprite = null;
      
      public function RankedIntroBlock()
      {
         super();
      }
      
      private static function updateFontSize(param1:TextField, param2:int) : void
      {
         var _loc3_:TextFormat = param1.getTextFormat();
         _loc3_.size = param2;
         param1.setTextFormat(_loc3_);
      }
      
      public final function dispose() : void
      {
         this.titleTf = null;
         this.descrTf = null;
         this.line = null;
      }
      
      public function setData(param1:RankedBattlesIntroBlockVO, param2:Boolean) : void
      {
         this.titleTf.text = param1.title;
         this.descrTf.text = param1.description;
         App.utils.commons.updateTextFieldSize(this.descrTf,false,true);
         this.line.visible = !param2;
      }
      
      private function updateLargeTitle() : void
      {
         this.titleTf.width = this.titleTf.textWidth + (TF_BORDER_PADDING << 1);
         var _loc1_:Number = this.descrTf.width / this.titleTf.width;
         this.titleTf.scaleX = this.titleTf.scaleY = _loc1_;
         this.titleTf.x ^= 0;
         this.titleTf.y = this.titleTf.height * (1 - _loc1_) >> 1;
      }
      
      override public function get width() : Number
      {
         return this.line.x;
      }
      
      override public function get height() : Number
      {
         return this.descrTf.y + this.descrTf.height;
      }
      
      public function set alignHeight(param1:int) : void
      {
         this.line.height = param1 + LINE_ADDITIONAL_HEIGHT;
      }
      
      public function set sizeID(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = Values.DEFAULT_INT;
         _loc3_ = TITLE_FONT_SIZE_SMALL;
         var _loc4_:int = DESCR_FONT_SIZE_SMALL;
         var _loc5_:int = DESCR_TOP_OFFSET_SMALL;
         var _loc6_:int = TF_HORIZONTAL_PADDING_SMALL;
         if(param1 == RankedBattlesIntro.VIEW_SIZE_ID_BIG)
         {
            _loc2_ = ALLOW_BLOCK_WIDTH_WIDE;
            _loc3_ = TITLE_FONT_SIZE_BIG;
            _loc4_ = DESCR_FONT_SIZE_BIG;
            _loc5_ = DESCR_TOP_OFFSET_BIG;
            _loc6_ = TF_HORIZONTAL_PADDING_BIG;
         }
         else if(param1 == RankedBattlesIntro.VIEW_SIZE_ID_MEDIUM)
         {
            _loc2_ = ALLOW_BLOCK_WIDTH_MEDIUM;
         }
         else
         {
            _loc2_ = ALLOW_BLOCK_WIDTH_SHORT;
         }
         this.descrTf.y = _loc5_;
         this.titleTf.width = this.descrTf.width = _loc2_ - (_loc6_ << 1);
         updateFontSize(this.titleTf,_loc3_);
         updateFontSize(this.descrTf,_loc4_);
         this.line.x = _loc2_;
         this.titleTf.x = this.descrTf.x = _loc6_;
         App.utils.commons.updateTextFieldSize(this.descrTf,false,true);
         if(this.titleTf.width <= this.titleTf.textWidth)
         {
            this.updateLargeTitle();
         }
      }
   }
}
