package net.wg.gui.components.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.controls.Button;
   import scaleform.clik.data.DataProvider;
   
   public interface IPaginatorArrowsController extends IDisposable, IEventDispatcher
   {
       
      
      function getPageIndex() : int;
      
      function getSelectedButton() : Button;
      
      function setPositions(param1:Point) : void;
      
      function updateSize(param1:int, param2:int) : void;
      
      function setPageIndex(param1:int) : void;
      
      function setPages(param1:DataProvider) : void;
   }
}
