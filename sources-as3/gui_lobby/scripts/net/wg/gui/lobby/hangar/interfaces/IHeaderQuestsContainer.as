package net.wg.gui.lobby.hangar.interfaces
{
   import flash.geom.Point;
   import net.wg.gui.lobby.hangar.data.HeaderQuestGroupVO;
   import net.wg.infrastructure.interfaces.ISprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IHeaderQuestsContainer extends IQuestsButtonsContainer, ISprite, IDisposable
   {
       
      
      function setData(param1:HeaderQuestGroupVO) : void;
      
      function hasInformersEqualNewData(param1:HeaderQuestGroupVO) : Boolean;
      
      function animExpand() : void;
      
      function animCollapse() : void;
      
      function animPosition(param1:int, param2:Object) : void;
      
      function get groupID() : String;
      
      function get cmptWidth() : int;
      
      function get isRightSide() : Boolean;
      
      function get position() : Point;
      
      function set position(param1:Point) : void;
      
      function getMinX() : int;
   }
}
