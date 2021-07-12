package net.wg.gui.lobby.epicBattles.interfaces.skillView
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ISkillParameterBlock extends IDisposable
   {
       
      
      function setBlockData(param1:Object) : void;
      
      function getHeight() : Number;
      
      function getDisplayObject() : DisplayObject;
   }
}
