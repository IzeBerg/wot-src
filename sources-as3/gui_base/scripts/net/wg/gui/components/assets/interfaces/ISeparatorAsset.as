package net.wg.gui.components.assets.interfaces
{
   import net.wg.infrastructure.interfaces.ISprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ISeparatorAsset extends IDisposable, ISprite
   {
       
      
      function setCenterAsset(param1:String) : void;
      
      function setSideAsset(param1:String) : void;
      
      function setType(param1:String) : void;
      
      function setMode(param1:String) : void;
      
      function clearAssets() : void;
      
      function get actualWidth() : Number;
   }
}
