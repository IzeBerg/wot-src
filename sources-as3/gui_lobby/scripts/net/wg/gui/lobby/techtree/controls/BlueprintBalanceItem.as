package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.techtree.data.BlueprintBalanceItemVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BlueprintBalanceItem extends Sprite implements IDisposable
   {
       
      
      public var titleTF:TextField = null;
      
      public var icon:UILoaderAlt;
      
      private var _data:BlueprintBalanceItemVO;
      
      public function BlueprintBalanceItem()
      {
         super();
      }
      
      protected function onDispose() : void
      {
         this._data = null;
         this.titleTF = null;
         this.icon.dispose();
         this.icon = null;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setData(param1:BlueprintBalanceItemVO) : void
      {
         this._data = param1;
         this.titleTF.htmlText = this._data.title;
         this.icon.source = this._data.iconPath;
         App.utils.commons.updateTextFieldSize(this.titleTF,true,true);
      }
      
      public function getFragmentCD() : int
      {
         return this._data.fragmentCD;
      }
   }
}
