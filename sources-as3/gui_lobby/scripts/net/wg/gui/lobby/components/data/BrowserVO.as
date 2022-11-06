package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BrowserVO extends DAAPIDataClass
   {
       
      
      public var waitingMessage:String = "";
      
      public var isModal:Boolean = false;
      
      public var isHidden:Boolean = false;
      
      public var bgAlpha:Number = 1.0;
      
      public var isCloseBtnVisible:Boolean = false;
      
      public function BrowserVO(param1:Object)
      {
         super(param1);
      }
   }
}
