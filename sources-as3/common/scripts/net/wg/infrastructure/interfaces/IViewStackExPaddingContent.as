package net.wg.infrastructure.interfaces
{
   import scaleform.clik.utils.Padding;
   
   public interface IViewStackExPaddingContent extends IViewStackExContent, IUIComponentEx
   {
       
      
      function setSizePadding(param1:Padding, param2:Boolean) : void;
   }
}
