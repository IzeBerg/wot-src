package net.wg.gui.login.impl.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   
   public class SocialGroup extends UIComponentEx
   {
       
      
      public var textField:TextField = null;
      
      public var bg:Sprite = null;
      
      public var socialList:SocialIconsList = null;
      
      private const ICONS_MARGIN:Number = 10;
      
      private const BG_HORIZONTAL_MARGIN:Number = 20;
      
      public function SocialGroup()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textField.x = this.BG_HORIZONTAL_MARGIN;
         this.textField.text = MENU.LOGIN_FASTENTER;
         this.socialList.x = this.textField.x + this.textField.textWidth + this.ICONS_MARGIN ^ 0;
         this.socialList.y = this.bg.height - this.socialList.rowHeight >> 1;
         this.updateBg();
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this.bg = null;
         this.socialList.dispose();
         this.socialList = null;
         super.onDispose();
      }
      
      public function updateList(param1:DataProvider) : void
      {
         if(!param1)
         {
            return;
         }
         this.socialList.dataProvider = param1;
         this.updateBg();
      }
      
      private function updateBg() : void
      {
         if(this.socialList.dataProvider)
         {
            this.bg.width = this.socialList.x + this.socialList.columnWidth * this.socialList.dataProvider.length + this.BG_HORIZONTAL_MARGIN ^ 0;
         }
         else
         {
            this.bg.width = this.socialList.x + this.BG_HORIZONTAL_MARGIN ^ 0;
         }
         this.bg.width += this.bg.width % 2;
         this.x = -this.bg.width >> 1;
      }
   }
}
