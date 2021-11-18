package net.wg.gui.bootcamp.messageWindow.views.bottom
{
   import flash.display.Sprite;
   import net.wg.gui.bootcamp.messageWindow.interfaces.IBottomRenderer;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.GroupEx;
   import scaleform.clik.data.DataProvider;
   
   public class BottomListViewBase extends Sprite implements IBottomRenderer
   {
      
      private static const REWARD_ITEM_RENDERER:String = "MessageRewardRendererUI";
      
      private static const RENDERER_WIDTH:int = 100;
      
      private static const RENDERER_HEIGHT:int = 90;
       
      
      private var _list:GroupEx;
      
      public function BottomListViewBase()
      {
         this._list = new GroupEx();
         super();
         this._list.layout = new CenterAlignedGroupLayout(RENDERER_WIDTH,RENDERER_HEIGHT);
         addChild(this._list);
      }
      
      public final function dispose() : void
      {
         this._list.dispose();
         this._list = null;
      }
      
      public function setData(param1:DataProvider) : void
      {
         this._list.itemRendererLinkage = REWARD_ITEM_RENDERER;
         this._list.dataProvider = param1;
      }
   }
}
