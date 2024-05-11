package net.wg.gui.lobby.rankedBattles19.components.interfaces
{
   import net.wg.infrastructure.interfaces.IMovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IStepArrow extends IMovieClip, IDisposable, IResizableRankedComponent
   {
       
      
      function runAnimation() : void;
      
      function useButtonMode(param1:Boolean) : void;
      
      function get state() : String;
      
      function set state(param1:String) : void;
   }
}
