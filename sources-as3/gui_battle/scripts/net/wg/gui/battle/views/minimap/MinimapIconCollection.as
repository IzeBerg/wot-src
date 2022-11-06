package net.wg.gui.battle.views.minimap
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MinimapIconCollection extends Sprite implements IDisposable
   {
      
      public static const ICON_ATTENTION:int = 0;
      
      public static const ICON_WAYPOINT:int = 1;
      
      public static const ICON_SPG:int = 2;
      
      public static const ICON_REPOSITION_VIEW:int = 3;
       
      
      public var attention:Sprite = null;
      
      public var SPG:Sprite = null;
      
      public var waypoint:Sprite = null;
      
      public var repositionView:Sprite = null;
      
      private var _disposed:Boolean = false;
      
      public function MinimapIconCollection()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.attention = null;
         this.SPG = null;
         this.waypoint = null;
         this.repositionView = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setIconType(param1:int) : void
      {
         this.waypoint.visible = false;
         this.SPG.visible = false;
         this.attention.visible = false;
         this.repositionView.visible = false;
         switch(param1)
         {
            case ICON_WAYPOINT:
               this.waypoint.visible = true;
               break;
            case ICON_SPG:
               this.SPG.visible = true;
               break;
            case ICON_REPOSITION_VIEW:
               this.repositionView.visible = true;
               break;
            default:
               this.attention.visible = true;
         }
      }
   }
}
