package net.wg.gui.components.advanced.vo
{
   import net.wg.data.VO.PaddingVO;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TutorialHintVO extends DAAPIDataClass
   {
      
      private static const PADDING:String = "padding";
       
      
      public var uniqueID:String = "";
      
      public var hintText:String = "";
      
      public var hasBox:Boolean = true;
      
      public var hasArrow:Boolean = false;
      
      public var arrowDir:String = "L";
      
      public var arrowLoop:Boolean = true;
      
      public var updateRuntime:Boolean = false;
      
      public var checkViewArea:Boolean = false;
      
      public var hideImmediately:Boolean = false;
      
      public var positionValue:Number = -1;
      
      public var textPadding:Number = -1;
      
      public var padding:PaddingVO = null;
      
      public function TutorialHintVO(param1:Object)
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
         this.arrowDir = null;
         super.onDispose();
      }
   }
}
