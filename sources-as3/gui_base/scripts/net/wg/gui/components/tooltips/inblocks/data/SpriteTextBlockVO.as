package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SpriteTextBlockVO extends DAAPIDataClass
   {
      
      private static const IMAGE_PADDING_FIELD_NAME:String = "spritePadding";
      
      private static const TEXTS_PADDING_FIELD_NAME:String = "textsPadding";
      
      private static const DESC_PADDING_FIELD_NAME:String = "descPadding";
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var spritePadding:PaddingVO = null;
      
      public var textsPadding:PaddingVO = null;
      
      public var textsOffset:int = -1;
      
      public var descPadding:PaddingVO = null;
      
      public var descLeading:int = 0;
      
      public var spriteAtLeft:Boolean = true;
      
      public var snapImage:Boolean = false;
      
      public var titleAtMiddle:Boolean = false;
      
      public var textsGap:int = 0;
      
      public var textsAlign:String = "";
      
      public function SpriteTextBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == IMAGE_PADDING_FIELD_NAME && param2 != null)
         {
            this.spritePadding = new PaddingVO(param2);
            return false;
         }
         if(param1 == TEXTS_PADDING_FIELD_NAME && param2 != null)
         {
            this.textsPadding = new PaddingVO(param2);
            return false;
         }
         if(param1 == DESC_PADDING_FIELD_NAME && param2 != null)
         {
            this.descPadding = new PaddingVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.spritePadding != null)
         {
            this.spritePadding.dispose();
            this.spritePadding = null;
         }
         if(this.textsPadding != null)
         {
            this.textsPadding.dispose();
            this.textsPadding = null;
         }
         if(this.descPadding != null)
         {
            this.descPadding.dispose();
            this.descPadding = null;
         }
         super.onDispose();
      }
   }
}
