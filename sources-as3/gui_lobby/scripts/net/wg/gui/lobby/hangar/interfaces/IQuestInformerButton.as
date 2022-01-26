package net.wg.gui.lobby.hangar.interfaces
{
   import flash.geom.Point;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.hangar.data.HeaderQuestsVO;
   
   public interface IQuestInformerButton extends ISoundButtonEx
   {
       
      
      function setData(param1:HeaderQuestsVO, param2:Boolean) : void;
      
      function setCollapsePoint(param1:int, param2:int) : void;
      
      function setExpandPoint(param1:int, param2:int) : void;
      
      function showContent(param1:Boolean, param2:int) : void;
      
      function hideContent(param1:Boolean, param2:int) : void;
      
      function get questType() : String;
      
      function get questID() : String;
      
      function get collapsePoint() : Point;
      
      function get expandPoint() : Point;
      
      function get isEnable() : Boolean;
   }
}
