package net.wg.gui.login
{
   import net.wg.gui.login.impl.vo.RssItemVo;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IRssNewsFeedRenderer extends IUIComponentEx
   {
       
      
      function setData(param1:RssItemVo) : void;
      
      function moveToY(param1:Number) : void;
      
      function hide() : void;
      
      function get itemId() : String;
      
      function get itemHeight() : Number;
      
      function get itemWidth() : Number;
      
      function get itemDataVo() : RssItemVo;
      
      function get isUsed() : Boolean;
   }
}
