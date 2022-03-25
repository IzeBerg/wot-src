package net.wg.gui.lobby.rankedBattles19.view.intro
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroBlockVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedIntroBlock extends Sprite implements IDisposable
   {
      
      private static const TF_HORIZONTAL_PADDING_BIG:int = 28;
      
      private static const TF_HORIZONTAL_PADDING_SMALL:int = 18;
      
      private static const ALLOW_BLOCK_WIDTH_WIDE:int = 420;
      
      private static const ALLOW_BLOCK_WIDTH_MEDIUM:int = 370;
      
      private static const ALLOW_BLOCK_WIDTH_SHORT:int = 320;
      
      private static const IMG_WIDTH_BIG:uint = 360;
      
      private static const IMG_WIDTH_SMALL:uint = 280;
      
      private static const IMG_HEIGHT_BIG:uint = 210;
      
      private static const IMG_HEIGHT_SMALL:uint = 164;
      
      private static const DESCR_TOP_OFFSET_SMALL:int = 30;
      
      private static const DESCR_TOP_OFFSET_BIG:int = 37;
      
      private static const TF_BORDER_PADDING:Number = 2;
       
      
      public var image:IImage = null;
      
      public var titleTf:TextField = null;
      
      public var descrTf:TextField = null;
      
      private var _disposed:Boolean = false;
      
      private var _allowWidth:int = 320;
      
      private var _imgWidth:int = 280;
      
      private var _imgHeight:int = 164;
      
      public function RankedIntroBlock()
      {
         super();
         this.image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
         this.image.dispose();
         this.image = null;
         this.titleTf = null;
         this.descrTf = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setData(param1:RankedBattlesIntroBlockVO, param2:int) : void
      {
         this.image.source = param1.imgSource;
         this.titleTf.htmlText = param1.title;
         this.descrTf.htmlText = param1.description;
         App.utils.commons.updateTextFieldSize(this.descrTf,false,true);
         if(param2 == RANKEDBATTLES_CONSTS.INTRO_STATE_DISABLED)
         {
            this.image.filters = [RankedIntroHelper.grayscaleFilter];
         }
         else
         {
            this.image.filters = [];
         }
      }
      
      private function updateLargeTitle() : void
      {
         this.titleTf.width = this.titleTf.textWidth + (TF_BORDER_PADDING << 1);
         var _loc1_:Number = this.descrTf.width / this.titleTf.width;
         this.titleTf.scaleX = this.titleTf.scaleY = _loc1_;
         this.titleTf.x ^= 0;
         this.titleTf.y = this._imgHeight + (this.titleTf.height * (1 - _loc1_) >> 1);
      }
      
      private function updateImageSize() : void
      {
         this.image.width = this._imgWidth;
         this.image.height = this._imgHeight;
      }
      
      override public function get width() : Number
      {
         return this._allowWidth;
      }
      
      override public function get height() : Number
      {
         return this.descrTf.y + this.descrTf.height;
      }
      
      public function set sizeID(param1:String) : void
      {
         var _loc2_:int = DESCR_TOP_OFFSET_SMALL;
         var _loc3_:int = TF_HORIZONTAL_PADDING_SMALL;
         this._imgWidth = IMG_WIDTH_BIG;
         this._imgHeight = IMG_HEIGHT_BIG;
         switch(param1)
         {
            case RankedBattlesIntro.VIEW_SIZE_ID_BIG:
               this._allowWidth = ALLOW_BLOCK_WIDTH_WIDE;
               _loc2_ = DESCR_TOP_OFFSET_BIG;
               _loc3_ = TF_HORIZONTAL_PADDING_BIG;
               break;
            case RankedBattlesIntro.VIEW_SIZE_ID_MEDIUM:
               this._allowWidth = ALLOW_BLOCK_WIDTH_MEDIUM;
               break;
            default:
               this._allowWidth = ALLOW_BLOCK_WIDTH_SHORT;
               this._imgWidth = IMG_WIDTH_SMALL;
               this._imgHeight = IMG_HEIGHT_SMALL;
         }
         this.updateImageSize();
         this.image.x = this._allowWidth - this._imgWidth >> 1;
         this.titleTf.scaleX = this.titleTf.scaleY = 1;
         this.titleTf.y = this._imgHeight;
         this.descrTf.y = this.titleTf.y + _loc2_;
         this.titleTf.width = this.descrTf.width = this._allowWidth - (_loc3_ << 1);
         this.titleTf.x = this.descrTf.x = _loc3_;
         App.utils.commons.updateTextFieldSize(this.descrTf,false,true);
         if(this.titleTf.width <= this.titleTf.textWidth)
         {
            this.updateLargeTitle();
         }
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         this.updateImageSize();
      }
   }
}
