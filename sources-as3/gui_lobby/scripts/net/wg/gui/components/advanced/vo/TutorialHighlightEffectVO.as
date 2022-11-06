package net.wg.gui.components.advanced.vo
{
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialHighlightEffectVO extends DAAPIDataClass
   {
      
      private static const PADDING:String = "padding";
       
      
      public var hideBorder:Boolean;
      
      public var padding:PaddingVO = null;
      
      public var customLinkage:String = "";
      
      public var addToParent:Boolean = false;
      
      public function TutorialHighlightEffectVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PADDING)
         {
            this.padding = new PaddingVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.padding != null)
         {
            this.padding.dispose();
            this.padding = null;
         }
         super.onDispose();
      }
   }
}
