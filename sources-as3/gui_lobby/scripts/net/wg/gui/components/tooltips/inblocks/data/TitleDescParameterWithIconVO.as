package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.VO.PaddingVO;
   
   public class TitleDescParameterWithIconVO extends TextParameterVO
   {
      
      private static const TITLE_PADDING_FIELD_NAME:String = "titlePadding";
      
      private static const ICON_PADDING_FIELD_NAME:String = "iconPadding";
      
      private static const VALUE_PADDING_FIELD_NAME:String = "valuePadding";
       
      
      public var titlePadding:PaddingVO = null;
      
      public var description:String = "";
      
      public var icon:String = "";
      
      public var iconPadding:PaddingVO = null;
      
      public var iconAlpha:Number = 1;
      
      public var valueAtRight:Boolean = false;
      
      public var valuePadding:PaddingVO = null;
      
      public var titleWidth:int = -1;
      
      public function TitleDescParameterWithIconVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TITLE_PADDING_FIELD_NAME && param2 != null)
         {
            this.titlePadding = new PaddingVO(param2);
            return false;
         }
         if(param1 == ICON_PADDING_FIELD_NAME && param2 != null)
         {
            this.iconPadding = new PaddingVO(param2);
            return false;
         }
         if(param1 == VALUE_PADDING_FIELD_NAME && param2 != null)
         {
            this.valuePadding = new PaddingVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.titlePadding != null)
         {
            this.titlePadding.dispose();
            this.titlePadding = null;
         }
         if(this.iconPadding != null)
         {
            this.iconPadding.dispose();
            this.iconPadding = null;
         }
         if(this.valuePadding != null)
         {
            this.valuePadding.dispose();
            this.valuePadding = null;
         }
         super.onDispose();
      }
   }
}
