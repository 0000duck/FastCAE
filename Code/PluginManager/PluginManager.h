#ifndef PLUGINMANAGER_H_
#define PLUGINMANAGER_H_

#include "PluginManagerAPI.h"
#include "DataProperty/DataBase.h"
#include "pluginBase.h"
#include <QList>

namespace GUI
{
	class MainWindow;
}

namespace Plugins
{
	class PluginBase;

	class PLUGINMANAGERAPI PluginManager : public DataProperty::DataBase
	{
		Q_OBJECT
	public:
		static PluginManager* getInstance();

		//���ز��
		void loadPlugs(GUI::MainWindow* m);
		//���ص������
		bool loadPlugin(QString name);
		//ж�ز��
		bool releasePlugin(QString name);
		//ж�ز��
		void releasePlugs();
		//����
		void reTranslate(QString lang);
		//��ȡ���
		PluginBase* getPluginByDescribe(QString des);
		//�������ͻ�ȡ���
		QList<PluginBase*> getPluginsByType(PluginType t);
	
	public slots:
		void manage();

	private:
		PluginManager() = default;
		~PluginManager() = default;

	private:
		static PluginManager* _instance;
		GUI::MainWindow* _mainWindow{};

		QList<PluginBase*> _pluginList{};

	};
}



#endif

